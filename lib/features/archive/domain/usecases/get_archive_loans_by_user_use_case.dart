import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/archive_loan_entity.dart';
import '../repositories/archive_repositories.dart';

class GetArchiveLoansByUserUseCase
    implements AsyncUseCaseWithParams<List<ArchiveLoanEntity>, String> {
  final ArchiveRepositories archiveRepositories;

  const GetArchiveLoansByUserUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, List<ArchiveLoanEntity>>> call(String params) async {
    return await archiveRepositories.getArchiveLoansByUser(params);
  }
}
