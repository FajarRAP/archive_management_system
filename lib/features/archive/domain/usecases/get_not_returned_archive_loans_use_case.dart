import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/archive_loan_entity.dart';
import '../repositories/archive_repositories.dart';

class GetNotReturnedArchiveLoansUseCase
    implements AsyncUseCaseNoParams<List<ArchiveLoanEntity>> {
  const GetNotReturnedArchiveLoansUseCase({required this.archiveRepositories});

  final ArchiveRepositories archiveRepositories;

  @override
  Future<Either<Failure, List<ArchiveLoanEntity>>> call() async {
    return await archiveRepositories.getNotReturnedArchiveLoans();
  }
}
