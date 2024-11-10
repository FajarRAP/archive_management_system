import 'package:archive_management_system/features/archive/domain/entities/archive_loan_entity.dart';
import 'package:archive_management_system/features/archive/domain/usecases/get_archive_loans_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/archive_entity.dart';
import '../../domain/usecases/borrow_archive_use_case.dart';
import '../../domain/usecases/delete_archive_use_case.dart';
import '../../domain/usecases/get_archives_use_case.dart';
import '../../domain/usecases/insert_archive_use_case.dart';
import '../../domain/usecases/update_archive_use_case.dart';

part 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit({
    required this.getArchivesUseCase,
    required this.getArchiveLoansUseCase,
    required this.insertArchiveUseCase,
    required this.updateArchiveUseCase,
    required this.deleteArchiveUseCase,
    required this.borrowArchiveUseCase,
  }) : super(ArchiveInitial());

  final GetArchivesUseCase getArchivesUseCase;
  final GetArchiveLoansUseCase getArchiveLoansUseCase;
  final InsertArchiveUseCase insertArchiveUseCase;
  final UpdateArchiveUseCase updateArchiveUseCase;
  final DeleteArchiveUseCase deleteArchiveUseCase;
  final BorrowArchiveUseCase borrowArchiveUseCase;

  Future<void> getArchive() async {
    emit(GetArchiveLoading());
    final result = await getArchivesUseCase();

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

  Future<void> updateArchive({required ArchiveEntity archive}) async {
    emit(UpdateArchiveLoading());

    final result = await updateArchiveUseCase(archive);

    result.fold(
      (l) => emit(UpdateArchiveError(message: l.message)),
      (r) => emit(UpdateArchiveLoaded('Berhasil mengupdate arsip')),
    );
  }

  Future<void> deleteArchive({required String archiveId}) async {
    emit(DeleteArchiveLoading());

    final result = await deleteArchiveUseCase(archiveId);

    result.fold(
      (l) => emit(DeleteArchiveError(message: l.message)),
      (r) => emit(DeleteArchiveLoaded('Berhasil menghapus arsip')),
    );
  }

  Future<void> borrowArchive({required ArchiveLoanEntity archiveLoan}) async {
    emit(BorrowArchiveLoading());

    final result = await borrowArchiveUseCase(archiveLoan);

    result.fold(
      (l) => emit(BorrowArchiveError(message: l.message)),
      (r) => emit(BorrowArchiveLoaded('Peminjaman Arsip Berhasil')),
    );
  }

  Future<void> getArchiveLoans() async {
    emit(GetArchiveLoansLoading());

    final result = await getArchiveLoansUseCase();

    result.fold(
      (l) => emit(GetArchiveLoansError(message: l.message)),
      (r) => emit(GetArchiveLoansLoaded(r)),
    );
  }
}
