import '../../domain/entities/archive_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

import '../../../../core/common/constants.dart';
import '../../../../dependency_injection.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/archive_cubit.dart';
import '../widgets/archive_filter_section.dart';
import '../widgets/archive_item.dart';
import '../widgets/menu_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final user = getIt.get<s.SupabaseClient>().auth.currentUser;
    authCubit.user = UserModel.fromUser(user!);

    return BlocBuilder<AuthCubit, AuthState>(
      bloc: authCubit..getCurrentUser(),
      buildWhen: (previous, current) => current is ProfileState,
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileLoaded) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
                    'Hai, ${user.userMetadata?['name'] ?? authCubit.userProfile.name}')),
            body: (user.userMetadata?['is_admin'] ?? false)
                ? const _AdminPage()
                : const _UserPage(),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _AdminPage extends StatelessWidget {
  const _AdminPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150,
            color: Colors.grey[300],
            child: const Center(
              child: Text(
                'Carousel Placeholder',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 32,
                childAspectRatio: 2.5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  MenuButton(
                    title: 'Arsip',
                    icon: Icons.archive,
                    route: archiveRoute,
                  ),
                  MenuButton(
                    title: 'Pengembalian',
                    icon: Icons.assignment_return,
                    route: returnArchiveRoute,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserPage extends StatelessWidget {
  const _UserPage();

  @override
  Widget build(BuildContext context) {
    final archiveCubit = context.read<ArchiveCubit>();

    return BlocBuilder<ArchiveCubit, ArchiveState>(
      bloc: archiveCubit..getArchive(),
      buildWhen: (previous, current) => current is GetArchive,
      builder: (context, state) {
        if (state is GetArchiveLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FilterArchiveByUrban) {
          final filteredArchives = archiveCubit.archives
              .where((archive) => archive.status == availableStatus)
              .where((archive) =>
                  archive.subdistrict == archiveCubit.getSubdistrict)
              .where((archive) => archive.urban == archiveCubit.getUrban)
              .toList();

          return RefreshIndicator(
            onRefresh: archiveCubit.getArchive,
            displacement: 10,
            child: ListView(
              children: [
                const ArchiveFilterSection(),
                _ArchiveList(archives: filteredArchives),
              ],
            ),
          );
        }

        if (state is FilterArchiveBySubdistrict) {
          final filteredArchives = archiveCubit.archives
              .where((archive) => archive.status == availableStatus)
              .where((archive) =>
                  archive.subdistrict == archiveCubit.getSubdistrict)
              .toList();

          return RefreshIndicator(
            onRefresh: archiveCubit.getArchive,
            displacement: 10,
            child: ListView(
              children: [
                const ArchiveFilterSection(),
                _ArchiveList(archives: filteredArchives),
              ],
            ),
          );
        }

        if (state is GetArchiveLoaded) {
          final availableArchives = archiveCubit.archives
              .where((archive) => archive.status == availableStatus)
              .toList();

          return RefreshIndicator(
            onRefresh: archiveCubit.getArchive,
            displacement: 10,
            child: ListView(
              children: [
                const ArchiveFilterSection(),
                _ArchiveList(archives: availableArchives),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _ArchiveList extends StatelessWidget {
  const _ArchiveList({required this.archives});

  final List<ArchiveEntity> archives;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ArchiveItem(archive: archives[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: archives.length,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
