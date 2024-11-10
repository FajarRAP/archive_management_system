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
        return Scaffold(
          appBar: AppBar(
            title: Text('Hai, ${authCubit.user?.userMetadata?['name']}'),
          ),
          body: user.userMetadata?['is_admin'] ? _AdminPage() : _UserPage(),
        );
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
    return BlocBuilder<ArchiveCubit, ArchiveState>(
      bloc: context.read<ArchiveCubit>()..getArchive(),
      buildWhen: (previous, current) => current is GetArchive,
      builder: (context, state) {
        if (state is GetArchiveLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetArchiveLoaded) {
          final availableArchives = state.archives
              .where((archive) => archive.status == availableStatus)
              .toList();
          return RefreshIndicator(
            onRefresh: context.read<ArchiveCubit>().getArchive,
            displacement: 10,
            child: ListView(
              children: [
                const ArchiveFilterSection(),
                ListView.separated(
                  itemBuilder: (context, index) =>
                      ArchiveItem(archive: availableArchives[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: availableArchives.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
