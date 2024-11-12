import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../repositories/archive_repositories.dart';

class GetArchiveStatisticsUseCase
    implements AsyncUseCaseNoParams<Map<String, dynamic>> {
  final ArchiveRepositories archiveRepositories;

  const GetArchiveStatisticsUseCase({required this.archiveRepositories});
  @override
  Future<Either<Failure, Map<String, dynamic>>> call() async {
    return await archiveRepositories.getArchiveStatistics();
  }
}
