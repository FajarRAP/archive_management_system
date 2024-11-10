import '../../../auth/data/models/profile_model.dart';
import '../../domain/entities/archive_loan_entity.dart';
import 'archive_model.dart';

ArchiveLoanModel mapArchiveLoan(Map<String, dynamic> archiveLoan) =>
    ArchiveLoanModel.fromJson(archiveLoan);

class ArchiveLoanModel extends ArchiveLoanEntity {
  const ArchiveLoanModel({
    super.archiveLoanId,
    super.returnedAt,
    required super.archive,
    required super.profile,
    required super.description,
    required super.borrowedDate,
  });

  factory ArchiveLoanModel.fromJson(Map<String, dynamic> json) =>
      ArchiveLoanModel(
        archiveLoanId: json['no_pinjam'],
        archive: ArchiveModel.fromJson(json['archive']),
        profile: ProfileModel.fromJson(json['profile']),
        description: json['keterangan'],
        borrowedDate: DateTime.parse(json['tanggal_pinjam']),
        returnedAt: json['returned_at'] == null
            ? null
            : DateTime.parse(json['returned_at']),
      );

  factory ArchiveLoanModel.fromEntity(ArchiveLoanEntity archiveLoan) =>
      ArchiveLoanModel(
          archiveLoanId: archiveLoan.archiveLoanId,
          archive: archiveLoan.archive,
          profile: archiveLoan.profile,
          description: archiveLoan.description,
          borrowedDate: archiveLoan.borrowedDate);

  Map<String, dynamic> toJson() => {
        'no_arsip': archive.archiveNumber,
        'profile_id': profile.id,
        'keterangan': description,
        'tanggal_pinjam': borrowedDate.toIso8601String(),
      };
}
