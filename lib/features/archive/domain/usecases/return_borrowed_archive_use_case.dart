import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/archive_loan_entity.dart';
import '../repositories/archive_repositories.dart';

class ReturnBorrowedArchiveUseCase
    implements AsyncUseCaseWithParams<ArchiveLoanEntity, ArchiveLoanEntity> {
  final ArchiveRepositories archiveRepositories;

  const ReturnBorrowedArchiveUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, ArchiveLoanEntity>> call(ArchiveLoanEntity params) async {
    return await archiveRepositories.returnBorrowedArchive(params);
  }
}
