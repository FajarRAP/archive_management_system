import 'package:archive_management_system/features/archive/domain/usecases/download_archive_report_use_case.dart';
import 'package:archive_management_system/features/archive/domain/usecases/get_archive_statistics_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/archive_entity.dart';
import '../../domain/entities/archive_loan_entity.dart';
import '../../domain/usecases/borrow_archive_use_case.dart';
import '../../domain/usecases/delete_archive_use_case.dart';
import '../../domain/usecases/get_archive_loans_by_user_use_case.dart';
import '../../domain/usecases/get_archive_loans_use_case.dart';
import '../../domain/usecases/get_archives_use_case.dart';
import '../../domain/usecases/insert_archive_use_case.dart';
import '../../domain/usecases/return_borrowed_archive_use_case.dart';
import '../../domain/usecases/update_archive_use_case.dart';

part 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit({
    required this.getArchivesUseCase,
    required this.getArchiveLoansUseCase,
    required this.getArchiveLoansByUserUseCase,
    required this.insertArchiveUseCase,
    required this.updateArchiveUseCase,
    required this.deleteArchiveUseCase,
    required this.borrowArchiveUseCase,
    required this.returnBorrowedArchiveUseCase,
    required this.getArchiveStatisticsUseCase,
    required this.downloadArchiveReportUseCase,
  }) : super(ArchiveInitial());

  final GetArchivesUseCase getArchivesUseCase;
  final GetArchiveLoansUseCase getArchiveLoansUseCase;
  final GetArchiveLoansByUserUseCase getArchiveLoansByUserUseCase;
  final InsertArchiveUseCase insertArchiveUseCase;
  final UpdateArchiveUseCase updateArchiveUseCase;
  final DeleteArchiveUseCase deleteArchiveUseCase;
  final BorrowArchiveUseCase borrowArchiveUseCase;
  final ReturnBorrowedArchiveUseCase returnBorrowedArchiveUseCase;
  final GetArchiveStatisticsUseCase getArchiveStatisticsUseCase;
  final DownloadArchiveReportUseCase downloadArchiveReportUseCase;

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
      (r) => emit(BorrowArchiveLoaded('Peminjaman arsip berhasil')),
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

  Future<void> returnBorrowedArchive(
      {required ArchiveLoanEntity archiveLoan}) async {
    emit(ReturnBorrowedArchiveLoading());

    final result = await returnBorrowedArchiveUseCase(archiveLoan);

    result.fold(
      (l) => emit(ReturnBorrowedArchiveError(message: l.message)),
      (r) => emit(
          ReturnBorrowedArchiveLoaded(message: 'Pengembalian arsip berhasil')),
    );
  }

  Future<void> getArchiveLoansByUser({required String userId}) async {
    emit(GetArchiveLoansLoading());

    final result = await getArchiveLoansByUserUseCase(userId);

    result.fold(
      (l) => emit(GetArchiveLoansError(message: l.message)),
      (r) => emit(GetArchiveLoansLoaded(r)),
    );
  }

  Future<void> getArchiveStatistics() async {
    emit(GetArchiveStatisticsLoading());

    final result = await getArchiveStatisticsUseCase();

    result.fold(
      (l) => emit(GetArchiveStatisticsError(message: l.message)),
      (r) => emit(GetArchiveStatisticsLoaded(data: r)),
    );
  }

  Future<void> downloadArchiveReport(
      {required List<ArchiveLoanEntity> archiveLoans}) async {
    emit(DownloadArchiveReportLoading());
    final result = await downloadArchiveReportUseCase(archiveLoans);

    result.fold(
      (l) => emit(DownloadArchiveReportError(message: l.message)),
      (r) => emit(DownloadArchiveReportLoaded(message: r)),
    );
  }
}
