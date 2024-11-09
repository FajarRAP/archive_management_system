import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/archive_entity.dart';
import '../repositories/archive_repositories.dart';

class DeleteArchiveUseCase
    implements AsyncUseCaseWithParams<ArchiveEntity, String> {
  final ArchiveRepositories archiveRepositories;

  const DeleteArchiveUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, ArchiveEntity>> call(String archiveId) async {
    return await archiveRepositories.deleteArchive(archiveId);
  }
}
