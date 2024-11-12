import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/common/constants.dart';
import '../models/archive_loan_model.dart';
import '../models/archive_model.dart';

abstract class ArchiveRemoteDataSource {
  Future<PostgrestResponse> getArchives();
  Future<PostgrestResponse> getArchiveLoans();
  Future<List<Map<String, dynamic>>> getArchiveLoansByUser(String userId);
  Future<List<Map<String, dynamic>>> insertArchive(ArchiveModel archive);
  Future<List<Map<String, dynamic>>> updateArchive(ArchiveModel archive);
  Future<List<Map<String, dynamic>>> deleteArchive(String archiveId);
  Future<List<Map<String, dynamic>>> borrowArchive(
      ArchiveLoanModel archiveLoan);
  Future<List<Map<String, dynamic>>> updateArchiveStatus(
      String archiveId, String status);
  Future<List<Map<String, dynamic>>> returnBorrowedArchive(
      String archiveLoanId);
  Future<int> getBorrowedArchiveLoansCount();
  Future<PostgrestResponse> getNotReturnedArchiveLoans();
}

class ArchiveRemoteDataSourceImpl extends ArchiveRemoteDataSource {
  final SupabaseClient supabase;

  ArchiveRemoteDataSourceImpl({required this.supabase});

  @override
  Future<PostgrestResponse> getArchives() async {
    return await supabase.from(archiveTable).select().count(CountOption.exact);
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
    return await supabase
        .from(archiveLoanTable)
        .insert(archiveLoan.toJson())
        .select(
            'archive:no_arsip(*), profile:profile_id(*), tanggal_pinjam, keterangan, created_at, returned_at');
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
  Future<PostgrestResponse> getArchiveLoans() async {
    return await supabase
        .from(archiveLoanTable)
        .select(
            'no_pinjam, archive:no_arsip(*), profile:profile_id(*), tanggal_pinjam, keterangan, created_at, returned_at')
        .count(CountOption.exact);
  }

  @override
  Future<List<Map<String, dynamic>>> returnBorrowedArchive(
      String archiveLoanId) async {
    return await supabase
        .from(archiveLoanTable)
        .update({'returned_at': DateTime.now().toIso8601String()})
        .eq('no_pinjam', archiveLoanId)
        .select(
            'no_pinjam, archive:no_arsip(*), profile:profile_id(*), tanggal_pinjam, keterangan, created_at, returned_at');
  }

  @override
  Future<List<Map<String, dynamic>>> getArchiveLoansByUser(
      String userId) async {
    return await supabase
        .from(archiveLoanTable)
        .select(
            'no_pinjam, archive:no_arsip(*), profile:profile_id(*), tanggal_pinjam, keterangan, created_at, returned_at')
        .eq('profile_id', userId);
  }

  @override
  Future<int> getBorrowedArchiveLoansCount() async {
    return await supabase.rpc('select_distinct_archive_loans');
  }

  @override
  Future<PostgrestResponse> getNotReturnedArchiveLoans() async {
    return await supabase
        .from(archiveLoanTable)
        .select()
        .isFilter('returned_at', null)
        .count(CountOption.exact);
  }
}
