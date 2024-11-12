import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../entities/archive_entity.dart';
import '../entities/archive_loan_entity.dart';

abstract class ArchiveRepositories {
  Future<Either<Failure, List<ArchiveEntity>>> getArchives();
  Future<Either<Failure, List<ArchiveLoanEntity>>> getArchiveLoans();
  Future<Either<Failure, List<ArchiveLoanEntity>>> getArchiveLoansByUser(
      String userId);
  Future<Either<Failure, ArchiveEntity>> insertArchive(ArchiveEntity archive);
  Future<Either<Failure, ArchiveEntity>> updateArchive(ArchiveEntity archive);
  Future<Either<Failure, ArchiveEntity>> deleteArchive(String archiveId);
  Future<Either<Failure, ArchiveLoanEntity>> borrowArchive(
      ArchiveLoanEntity archiveLoan);
  Future<Either<Failure, ArchiveLoanEntity>> returnBorrowedArchive(
      ArchiveLoanEntity archiveLoan);
  Future<Either<Failure, Map<String, dynamic>>> getArchiveStatistics();
}
