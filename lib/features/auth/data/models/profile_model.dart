import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.name,
    required super.employeeId,
    required super.jobTitle,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'],
        name: json['nama'],
        employeeId: json['nik'],
        jobTitle: json['jabatan'],
      );
}
