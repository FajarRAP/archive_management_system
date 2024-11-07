import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../entities/archive_entity.dart';

abstract class ArchiveRepositories {
  Future<Either<Failure, List<ArchiveEntity>>> getArchive();
  Future<Either<Failure, ArchiveEntity>> insertArchive(ArchiveEntity archive);
  Future<Either<Failure, ArchiveEntity>> updateArchive(ArchiveEntity archive);
  Future<Either<Failure, ArchiveEntity>> deleteArchive(String archiveId);
}