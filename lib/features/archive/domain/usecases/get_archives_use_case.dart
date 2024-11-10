import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/archive_entity.dart';
import '../repositories/archive_repositories.dart';

class GetArchivesUseCase implements AsyncUseCaseNoParams<List<ArchiveEntity>> {
  final ArchiveRepositories archiveRepositories;

  const GetArchivesUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, List<ArchiveEntity>>> call() async {
    return await archiveRepositories.getArchives();
  }
}
