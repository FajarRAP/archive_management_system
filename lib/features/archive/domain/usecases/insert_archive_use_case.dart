import 'package:archive_management_system/core/common/failure.dart';
import 'package:archive_management_system/core/common/use_cases.dart';
import 'package:archive_management_system/features/archive/domain/entities/archive_entity.dart';
import 'package:archive_management_system/features/archive/domain/repositories/archive_repositories.dart';
import 'package:dartz/dartz.dart';

class InsertArchiveUseCase
    implements AsyncUseCaseWithParams<ArchiveEntity, ArchiveEntity> {
  final ArchiveRepositories archiveRepositories;

  const InsertArchiveUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, ArchiveEntity>> call(ArchiveEntity archive) async {
    return archiveRepositories.insertArchive(archive);
  }
}
