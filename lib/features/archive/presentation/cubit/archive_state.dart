part of 'archive_cubit.dart';

@immutable
sealed class ArchiveState {}

final class ArchiveInitial extends ArchiveState {}

class GetArchive extends ArchiveState {}

class GetArchiveLoans extends ArchiveState {}

class GetArchiveStatistics extends ArchiveState {}

class InsertArchive extends ArchiveState {}

class UpdateArchive extends ArchiveState {}

class DeleteArchive extends ArchiveState {}

class BorrowArchive extends ArchiveState {}

class ReturnBorrowedArchive extends ArchiveState {}

class DownloadArchiveReport extends ArchiveState {}

class GetArchiveLoading extends GetArchive {}

class GetArchiveLoaded extends GetArchive {}

class GetArchiveError extends GetArchive {
  final String message;

  GetArchiveError({required this.message});
}

class FilterArchiveBySubdistrict extends GetArchive {}

class FilterArchiveByUrban extends GetArchive {}

class InsertArchiveLoading extends InsertArchive {}

class InsertArchiveLoaded extends InsertArchive {
  final String message;

  InsertArchiveLoaded(this.message);
}

class InsertArchiveError extends InsertArchive {
  final String message;

  InsertArchiveError({required this.message});
}

class UpdateArchiveLoading extends UpdateArchive {}

class UpdateArchiveLoaded extends UpdateArchive {
  final String message;

  UpdateArchiveLoaded(this.message);
}

class UpdateArchiveError extends UpdateArchive {
  final String message;

  UpdateArchiveError({required this.message});
}

class DeleteArchiveLoading extends DeleteArchive {}

class DeleteArchiveLoaded extends DeleteArchive {
  final String message;

  DeleteArchiveLoaded(this.message);
}

class DeleteArchiveError extends DeleteArchive {
  final String message;

  DeleteArchiveError({required this.message});
}

class BorrowArchiveLoading extends BorrowArchive {}

class BorrowArchiveLoaded extends BorrowArchive {
  final String message;

  BorrowArchiveLoaded(this.message);
}

class BorrowArchiveError extends BorrowArchive {
  final String message;

  BorrowArchiveError({required this.message});
}

class GetArchiveLoansLoading extends GetArchiveLoans {}

class GetArchiveLoansLoaded extends GetArchiveLoans {}

class GetArchiveLoansError extends GetArchiveLoans {
  final String message;

  GetArchiveLoansError({required this.message});
}

class ReturnBorrowedArchiveLoading extends ReturnBorrowedArchive {}

class ReturnBorrowedArchiveLoaded extends ReturnBorrowedArchive {
  final String message;

  ReturnBorrowedArchiveLoaded({required this.message});
}

class ReturnBorrowedArchiveError extends ReturnBorrowedArchive {
  final String message;

  ReturnBorrowedArchiveError({required this.message});
}

class GetArchiveStatisticsLoading extends GetArchiveStatistics {}

class GetArchiveStatisticsLoaded extends GetArchiveStatistics {
  final Map<String, dynamic> data;

  GetArchiveStatisticsLoaded({required this.data});
}

class GetArchiveStatisticsError extends GetArchiveStatistics {
  final String message;

  GetArchiveStatisticsError({required this.message});
}

class DownloadArchiveReportLoading extends DownloadArchiveReport {}

class DownloadArchiveReportLoaded extends DownloadArchiveReport {
  final String message;

  DownloadArchiveReportLoaded({required this.message});
}

class DownloadArchiveReportError extends DownloadArchiveReport {
  final String message;

  DownloadArchiveReportError({required this.message});
}
