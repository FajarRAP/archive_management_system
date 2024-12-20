import '../../domain/entities/archive_entity.dart';

ArchiveModel mapArchive(dynamic archive) =>
    ArchiveModel.fromJson(archive);

class ArchiveModel extends ArchiveEntity {
  const ArchiveModel({
    super.archiveNumber,
    required super.subdistrict,
    required super.urban,
    required super.status,
  });

  factory ArchiveModel.fromJson(Map<String, dynamic> json) => ArchiveModel(
      archiveNumber: json['no_arsip'],
      subdistrict: json['kecamatan'],
      urban: json['kelurahan'],
      status: json['status']);

  factory ArchiveModel.fromEntity(ArchiveEntity archive) => ArchiveModel(
      archiveNumber: archive.archiveNumber,
      subdistrict: archive.subdistrict,
      urban: archive.urban,
      status: archive.status);

  Map<String, dynamic> toJson() => {
        'kecamatan': subdistrict,
        'kelurahan': urban,
        'status': status,
      };
}
