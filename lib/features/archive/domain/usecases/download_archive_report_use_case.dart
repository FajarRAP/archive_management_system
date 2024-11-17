import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/archive_loan_entity.dart';
import '../repositories/archive_repositories.dart';

class DownloadArchiveReportUseCase
    implements AsyncUseCaseWithParams<String, List<ArchiveLoanEntity>> {
  final ArchiveRepositories archiveRepositories;

  const DownloadArchiveReportUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, String>> call(List<ArchiveLoanEntity> params) async {
    return await archiveRepositories.downloadArchiveReport(params);
  }
}
