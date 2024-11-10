import '../../../auth/domain/entities/profile_entity.dart';
import 'archive_entity.dart';

class ArchiveLoanEntity {
  final int? archiveLoanId;
  final ArchiveEntity archive;
  final ProfileEntity profile;
  final String description;
  final DateTime borrowedDate;
  final DateTime? returnedAt;

  const ArchiveLoanEntity({
    this.archiveLoanId,
    this.returnedAt,
    required this.archive,
    required this.profile,
    required this.description,
    required this.borrowedDate,
  });
}
