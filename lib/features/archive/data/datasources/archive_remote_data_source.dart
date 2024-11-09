import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/archive_model.dart';

abstract class ArchiveRemoteDataSource {
  Future<List<Map<String, dynamic>>> getArchive();
  Future<List<Map<String, dynamic>>> insertArchive(ArchiveModel archive);
  Future<List<Map<String, dynamic>>> updateArchive(ArchiveModel archive);
  Future<List<Map<String, dynamic>>> deleteArchive(String archiveId);
}

class ArchiveRemoteDataSourceImpl extends ArchiveRemoteDataSource {
  final SupabaseClient supabase;

  ArchiveRemoteDataSourceImpl({required this.supabase});

  @override
  Future<List<Map<String, dynamic>>> getArchive() async {
    return await supabase.from('archives').select();
  }

  @override
  Future<List<Map<String, dynamic>>> insertArchive(ArchiveModel archive) async {
    return await supabase.from('archives').insert(archive.toJson()).select();
  }

  @override
  Future<List<Map<String, dynamic>>> updateArchive(ArchiveModel archive) async {
    return await supabase
        .from('archives')
        .update(archive.toJson())
        .eq('id', archive.archiveNumber!)
        .select();
  }

  @override
  Future<List<Map<String, dynamic>>> deleteArchive(String archiveId) async {
    return await supabase
        .from('archives')
        .delete()
        .eq('id', archiveId)
        .select();
  }
}
