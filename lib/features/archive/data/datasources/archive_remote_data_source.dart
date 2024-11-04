import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/archive_model.dart';

abstract class ArchiveRemoteDataSource {
  Future<List<Map<String, dynamic>>> getArchive();
  Future<List<Map<String, dynamic>>> insertArchive(ArchiveModel archive);
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
}
