class ArchiveEntity {
  final int? archiveId;
  final int archiveNumber;
  final String subdistrict;
  final String urban;
  final String status;

  const ArchiveEntity({
    this.archiveId,
    required this.archiveNumber,
    required this.subdistrict,
    required this.urban,
    required this.status,
  });
}
