part of 'archive_cubit.dart';

@immutable
sealed class ArchiveState {}

final class ArchiveInitial extends ArchiveState {}

class GetArchive extends ArchiveState {}

class InsertArchive extends ArchiveState {}

class UpdateArchive extends ArchiveState {}

class DeleteArchive extends ArchiveState {}

class GetArchiveLoading extends GetArchive {}

class GetArchiveLoaded extends GetArchive {
  final List<ArchiveEntity> archives;

  GetArchiveLoaded(this.archives);
}

class GetArchiveError extends GetArchive {
  final String message;

  GetArchiveError({required this.message});
}

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
