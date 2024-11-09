import '../../../auth/data/models/profile_model.dart';
import '../../domain/entities/archive_loan_entity.dart';
import 'archive_model.dart';

class ArchiveLoanModel extends ArchiveLoanEntity {
  const ArchiveLoanModel({
    required super.archive,
    required super.profile,
    required super.description,
    required super.borrowedDate,
  });

  factory ArchiveLoanModel.fromJson(Map<String, dynamic> json) =>
      ArchiveLoanModel(
        archive: ArchiveModel.fromJson(json['archive']),
        profile: ProfileModel.fromJson(json['profile']),
        description: json['keterangan'],
        borrowedDate: DateTime.parse(json['tanggal_pinjam']),
      );
}
