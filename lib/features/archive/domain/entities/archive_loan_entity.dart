import '../../../auth/domain/entities/profile_entity.dart';
import 'archive_entity.dart';

class ArchiveLoanEntity {
  final ArchiveEntity archive;
  final ProfileEntity profile;
  final String description;
  final DateTime borrowedDate;

  const ArchiveLoanEntity({
    required this.archive,
    required this.profile,
    required this.description,
    required this.borrowedDate,
  });
}
