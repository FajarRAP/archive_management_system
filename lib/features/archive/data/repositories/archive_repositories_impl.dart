import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/common/failure.dart';
import '../../domain/entities/archive_entity.dart';
import '../../domain/repositories/archive_repositories.dart';
import '../datasources/archive_remote_data_source.dart';
import '../models/archive_model.dart';

class ArchiveRepositoriesImpl extends ArchiveRepositories {
  final ArchiveRemoteDataSource archiveRemoteDataSource;

  ArchiveRepositoriesImpl({required this.archiveRemoteDataSource});

  @override
  Future<Either<Failure, List<ArchiveEntity>>> getArchive() async {
    try {
      final result = await archiveRemoteDataSource.getArchive();
      return Right(
          result.map((archive) => ArchiveModel.fromJson(archive)).toList());
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
      final archives =
          result.map((archive) => ArchiveModel.fromJson(archive)).toList();
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
}
