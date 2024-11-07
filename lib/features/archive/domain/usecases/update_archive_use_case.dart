import 'package:archive_management_system/core/common/failure.dart';
import 'package:archive_management_system/core/common/use_cases.dart';
import 'package:archive_management_system/features/archive/domain/entities/archive_entity.dart';
import 'package:archive_management_system/features/archive/domain/repositories/archive_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdateArchiveUseCase
    implements AsyncUseCaseWithParams<ArchiveEntity, ArchiveEntity> {
  final ArchiveRepositories archiveRepositories;

  const UpdateArchiveUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, ArchiveEntity>> call(ArchiveEntity params) async {
    return await archiveRepositories.updateArchive(params);
  }
}
