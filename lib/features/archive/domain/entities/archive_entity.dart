class ArchiveEntity {
  final int? archiveNumber;
  final String subdistrict;
  final String urban;
  final String status;

  const ArchiveEntity({
    this.archiveNumber,
    required this.subdistrict,
    required this.urban,
    required this.status,
  });
}
