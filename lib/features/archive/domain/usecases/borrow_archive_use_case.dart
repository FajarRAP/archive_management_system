import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/archive_loan_entity.dart';
import '../repositories/archive_repositories.dart';

class BorrowArchiveUseCase
    implements
        AsyncUseCaseWithParams<ArchiveLoanEntity, BorrowArchiveUseCaseParams> {
  final ArchiveRepositories archiveRepositories;

  const BorrowArchiveUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, ArchiveLoanEntity>> call(
      BorrowArchiveUseCaseParams params) async {
    return await archiveRepositories.borrowArchive(params.archiveId,
        params.profileId, params.description, params.borrowedDate);
  }
}

class BorrowArchiveUseCaseParams {
  final String archiveId;
  final String profileId;
  final String description;
  final DateTime borrowedDate;

  const BorrowArchiveUseCaseParams({
    required this.archiveId,
    required this.profileId,
    required this.description,
    required this.borrowedDate,
  });
}
