import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/archive_entity.dart';
import '../repositories/archive_repositories.dart';

class InsertArchiveUseCase
    implements AsyncUseCaseWithParams<ArchiveEntity, ArchiveEntity> {
  final ArchiveRepositories archiveRepositories;

  const InsertArchiveUseCase({required this.archiveRepositories});

  @override
  Future<Either<Failure, ArchiveEntity>> call(ArchiveEntity archive) async {
    return archiveRepositories.insertArchive(archive);
  }
}
