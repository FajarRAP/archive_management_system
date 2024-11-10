import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/common/constants.dart';
import '../models/archive_loan_model.dart';
import '../models/archive_model.dart';

abstract class ArchiveRemoteDataSource {
  Future<List<Map<String, dynamic>>> getArchives();
  Future<List<Map<String, dynamic>>> getArchiveLoans();
  Future<List<Map<String, dynamic>>> insertArchive(ArchiveModel archive);
  Future<List<Map<String, dynamic>>> updateArchive(ArchiveModel archive);
  Future<List<Map<String, dynamic>>> deleteArchive(String archiveId);
  Future<List<Map<String, dynamic>>> borrowArchive(
      ArchiveLoanModel archiveLoan);
  Future<List<Map<String, dynamic>>> updateArchiveStatus(
      String archiveId, String status);
}

class ArchiveRemoteDataSourceImpl extends ArchiveRemoteDataSource {
  final SupabaseClient supabase;

  ArchiveRemoteDataSourceImpl({required this.supabase});

  @override
  Future<List<Map<String, dynamic>>> getArchives() async {
    return await supabase.from(archiveTable).select();
  }

  @override
  Future<List<Map<String, dynamic>>> insertArchive(ArchiveModel archive) async {
    return await supabase.from(archiveTable).insert(archive.toJson()).select();
  }

  @override
  Future<List<Map<String, dynamic>>> updateArchive(ArchiveModel archive) async {
    return await supabase
        .from(archiveTable)
        .update(archive.toJson())
        .eq('no_arsip', '${archive.archiveNumber}')
        .select();
  }

  @override
  Future<List<Map<String, dynamic>>> deleteArchive(String archiveId) async {
    return await supabase
        .from(archiveTable)
        .delete()
        .eq('no_arsip', archiveId)
        .select();
  }

  @override
  Future<List<Map<String, dynamic>>> borrowArchive(
      ArchiveLoanModel archiveLoan) async {
    // 'no_arsip': archiveId,
    // 'profile_id': profileId,
    // 'keterangan': description,
    // 'tanggal_pinjam': borrowedDate.toIso8601String(),
    return await supabase
        .from(archiveLoanTable)
        .insert(archiveLoan.toJson())
        .select(
            'archive:no_arsip(*), profile:profile_id(*), tanggal_pinjam, keterangan, created_at');
  }

  @override
  Future<List<Map<String, dynamic>>> updateArchiveStatus(
      String archiveId, String status) async {
    return await supabase
        .from(archiveTable)
        .update({'status': status})
        .eq('no_arsip', archiveId)
        .select();
  }

  @override
  Future<List<Map<String, dynamic>>> getArchiveLoans() async {
    return await supabase.from(archiveLoanTable).select(
        'no_pinjam, archive:no_arsip(*), profile:profile_id(*), tanggal_pinjam, keterangan, created_at');
  }
}
