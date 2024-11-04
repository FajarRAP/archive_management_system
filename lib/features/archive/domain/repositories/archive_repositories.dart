import 'package:archive_management_system/core/common/failure.dart';
import 'package:archive_management_system/features/archive/domain/entities/archive_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ArchiveRepositories {
  Future<Either<Failure, List<ArchiveEntity>>> getArchive();
  Future<Either<Failure, ArchiveEntity>> insertArchive(ArchiveEntity archive);
}