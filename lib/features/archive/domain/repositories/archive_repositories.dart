import 'package:archive_management_system/features/archive/domain/entities/archive_loan_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../entities/archive_entity.dart';

abstract class ArchiveRepositories {
  Future<Either<Failure, List<ArchiveEntity>>> getArchive();
  Future<Either<Failure, ArchiveEntity>> insertArchive(ArchiveEntity archive);
  Future<Either<Failure, ArchiveEntity>> updateArchive(ArchiveEntity archive);
  Future<Either<Failure, ArchiveEntity>> deleteArchive(String archiveId);
  Future<Either<Failure, ArchiveLoanEntity>> borrowArchive(String archiveId,
      String profileId, String description, DateTime borrowedDate);
}
