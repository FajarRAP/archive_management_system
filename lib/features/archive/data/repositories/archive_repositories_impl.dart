import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      return Right(result.map(mapArchive).toList());
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
    } catch (e, s) {
      print(e);
      print(s);
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
      final datas = await archiveRemoteDataSource.getArchiveLoans();

      return Right(datas.map(mapArchiveLoan).toList());
    } catch (e) {
      return Left(Failure());
    }
  }
}
