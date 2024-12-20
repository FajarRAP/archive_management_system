import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:external_path/external_path.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/common/failure.dart';
import '../../domain/entities/archive_entity.dart';
import '../../domain/entities/archive_loan_entity.dart';
import '../../domain/repositories/archive_repositories.dart';
import '../datasources/archive_remote_data_source.dart';
import '../models/archive_loan_model.dart';
import '../models/archive_model.dart';

class ArchiveRepositoriesImpl extends ArchiveRepositories {
  final ArchiveRemoteDataSource archiveRemoteDataSource;

  ArchiveRepositoriesImpl({required this.archiveRemoteDataSource});

  @override
  Future<Either<Failure, List<ArchiveEntity>>> getArchives() async {
    try {
      final result = await archiveRemoteDataSource.getArchives();
      final datas = result.data as List;
      return Right(datas.map(mapArchive).toList());
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ArchiveEntity>> insertArchive(
      ArchiveEntity archive) async {
    try {
      final result = await archiveRemoteDataSource
          .insertArchive(ArchiveModel.fromEntity(archive));
      final archives = result.map(mapArchive).toList();
      return Right(archives.first);
    } on PostgrestException catch (pe) {
      switch (pe.code) {
        case '23505':
          return Left(Failure(message: 'Nomor Arsip Sudah Ada'));
        default:
          return Left(Failure());
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ArchiveEntity>> deleteArchive(String archiveId) async {
    try {
      final result = await archiveRemoteDataSource.deleteArchive(archiveId);
      final archives = result.map(mapArchive).toList();
      return Right(archives.first);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ArchiveEntity>> updateArchive(
      ArchiveEntity archive) async {
    try {
      final result = await archiveRemoteDataSource
          .updateArchive(ArchiveModel.fromEntity(archive));
      final archives = result.map(mapArchive).toList();
      return Right(archives.first);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ArchiveLoanEntity>> borrowArchive(
      ArchiveLoanEntity archiveLoan) async {
    try {
      await archiveRemoteDataSource.updateArchiveStatus(
        '${archiveLoan.archive.archiveNumber}',
        borrowedStatus,
      );
      final datas = await archiveRemoteDataSource
          .borrowArchive(ArchiveLoanModel.fromEntity(archiveLoan));

      return Right(ArchiveLoanModel.fromJson(datas.first));
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<ArchiveLoanEntity>>> getArchiveLoans() async {
    try {
      final response = await archiveRemoteDataSource.getArchiveLoans();
      final datas = response.data as List;

      return Right(datas.map(mapArchiveLoan).toList());
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ArchiveLoanEntity>> returnBorrowedArchive(
      ArchiveLoanEntity archiveLoan) async {
    try {
      await archiveRemoteDataSource.updateArchiveStatus(
          '${archiveLoan.archive.archiveNumber}', availableStatus);

      final datas = await archiveRemoteDataSource
          .returnBorrowedArchive('${archiveLoan.archiveLoanId}');

      return Right(ArchiveLoanModel.fromJson(datas.first));
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<ArchiveLoanEntity>>> getArchiveLoansByUser(
      String userId) async {
    try {
      final datas = await archiveRemoteDataSource.getArchiveLoansByUser(userId);

      return Right(datas.map(mapArchiveLoan).toList());
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getArchiveStatistics() async {
    try {
      final archiveLoansResponse =
          await archiveRemoteDataSource.getArchiveLoans();
      final archiveLoansCount =
          await archiveRemoteDataSource.getBorrowedArchiveLoansCount();
      final notReturnedArchiveLoans =
          await archiveRemoteDataSource.getNotReturnedArchiveLoans();
      final archivesResponse = await archiveRemoteDataSource.getArchives();
      final archiveLoansOrderByBorrowedTime =
          await archiveRemoteDataSource.getArchiveLoansOrderByBorrowedTime();
      final archiveLoansTotal = archiveLoansResponse.count;

      return Right({
        archiveLoansTotalKey: archiveLoansTotal,
        archiveLoansCountKey: archiveLoansCount,
        archiveLoansNotReturnedCountKey: notReturnedArchiveLoans.count,
        archivesCountKey: archivesResponse.count,
        archiveLoansDataKey:
            archiveLoansOrderByBorrowedTime.map(mapArchiveLoan).toList(),
      });
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, String>> downloadArchiveReport(
      List<ArchiveLoanEntity> archiveLoans) async {
    try {
      final dateFormat = DateFormat('dd-MM-yyyy_HH-mm-ss');
      final dateNow = dateFormat.format(DateTime.now());
      final downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      final workbook = Workbook();
      final sheet = workbook.worksheets[0];

      sheet
        ..getRangeByIndex(1, 1).setText('No. Arsip')
        ..getRangeByIndex(1, 2).setText('Kecamatan')
        ..getRangeByIndex(1, 3).setText('Kelurahan')
        ..getRangeByIndex(1, 4).setText('Status')
        ..getRangeByIndex(1, 5).setText('Peminjam');

      for (var i = 0; i < archiveLoans.length; i++) {
        sheet
          ..getRangeByIndex(i + 2, 1)
              .setText('${archiveLoans[i].archive.archiveNumber}')
          ..getRangeByIndex(i + 2, 2)
              .setText(archiveLoans[i].archive.subdistrict)
          ..getRangeByIndex(i + 2, 3).setText(archiveLoans[i].archive.urban)
          ..getRangeByIndex(i + 2, 4).setText(archiveLoans[i].returnedAt == null
              ? borrowedStatus
              : availableStatus)
          ..getRangeByIndex(i + 2, 5).setText(archiveLoans[i].profile.name);
      }

      final bytes = workbook.saveAsStream();

      File('$downloadPath/archive-report_$dateNow.xlsx').writeAsBytes(bytes);
      workbook.dispose();

      return Right('Berhasil mengunduh laporan');
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<ArchiveLoanEntity>>>
      getNotReturnedArchiveLoans() async {
    try {
      final response =
          await archiveRemoteDataSource.getNotReturnedArchiveLoans();
      final datas = response.data as List;

      return Right(datas.map(mapArchiveLoan).toList());
    } catch (e) {
      return Left(Failure());
    }
  }
}
