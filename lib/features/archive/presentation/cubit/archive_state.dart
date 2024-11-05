part of 'archive_cubit.dart';

@immutable
sealed class ArchiveState {}

final class ArchiveInitial extends ArchiveState {}

class GetArchive extends ArchiveState {}
class InsertArchive extends ArchiveState {}

class GetArchiveLoading extends GetArchive {}

class GetArchiveLoaded extends GetArchive {
  final List<ArchiveEntity> archive;

  GetArchiveLoaded(this.archive);
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
