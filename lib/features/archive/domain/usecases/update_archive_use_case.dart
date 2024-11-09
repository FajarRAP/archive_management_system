import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/archive_entity.dart';
import '../repositories/archive_repositories.dart';

class UpdateArchiveUseCase
    implements AsyncUseCaseWithParams<ArchiveEntity, ArchiveEntity> {
  final ArchiveRepositories archiveRepositories;

  const UpdateArchiveUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, ArchiveEntity>> call(ArchiveEntity params) async {
    return await archiveRepositories.updateArchive(params);
  }
}
