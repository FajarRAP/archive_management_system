import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/archive_entity.dart';
import '../../domain/usecases/get_archive_use_case.dart';
import '../../domain/usecases/insert_archive_use_case.dart';

part 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit({
    required this.getArchiveUseCase,
    required this.insertArchiveUseCase,
  }) : super(ArchiveInitial());

  final GetArchiveUseCase getArchiveUseCase;
  final InsertArchiveUseCase insertArchiveUseCase;

  Future<void> getArchive() async {
    emit(GetArchiveLoading());
    final result = await getArchiveUseCase();

    result.fold(
      (l) => emit(GetArchiveError(message: l.message)),
      (r) => emit(GetArchiveLoaded(r)),
    );
  }

  Future<void> insertArchive({required ArchiveEntity archive}) async {
    emit(InsertArchiveLoading());

    final result = await insertArchiveUseCase(archive);

    result.fold(
      (l) => emit(InsertArchiveError(message: l.message)),
      (r) => emit(InsertArchiveLoaded('Berhasil menambahkan arsip')),
    );
  }
}
