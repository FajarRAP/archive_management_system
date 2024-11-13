import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

import '../../../../core/common/constants.dart';
import '../../../../dependency_injection.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/archive_cubit.dart';
import '../widgets/activity_item.dart';
import '../widgets/return_archive_item.dart';
import '../widgets/statistics_card.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = getIt
            .get<s.SupabaseClient>()
            .auth
            .currentUser
            ?.userMetadata?['is_admin'] ??
        false;
    return isAdmin ? const _AdminPage() : const _UserPage();
  }
}

class _AdminPage extends StatelessWidget {
  const _AdminPage();

  @override
  Widget build(BuildContext context) {
    final archiveCubit = context.read<ArchiveCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Laporan')),
      body: BlocBuilder<ArchiveCubit, ArchiveState>(
        bloc: archiveCubit..getArchiveStatistics(),
        buildWhen: (previous, current) => current is GetArchiveStatistics,
        builder: (context, state) {
          if (state is GetArchiveStatisticsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetArchiveStatisticsLoaded) {
            return RefreshIndicator(
              onRefresh: archiveCubit.getArchiveStatistics,
              displacement: 10,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Statistik',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        childAspectRatio: 1.25,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          StatisticsCard(
                            title: 'Total Peminjaman',
                            value: '${state.data[archiveLoansTotalKey]}',
                            icon: Icons.book_rounded,
                          ),
                          StatisticsCard(
                            title: 'Arsip Dipinjam',
                            value: '${state.data[archiveLoansCountKey]}',
                            icon: Icons.inventory_2_rounded,
                          ),
                          StatisticsCard(
                            title: 'Belum Dikembalikan',
                            value:
                                '${state.data[archiveLoansNotReturnedCountKey]}',
                            icon: Icons.pending_actions_rounded,
                          ),
                          StatisticsCard(
                            title: 'Total Arsip',
                            value: '${state.data[archivesCountKey]}',
                            icon: Icons.archive_rounded,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aktivitas Terbaru',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        elevation: 0,
                        color: colorScheme.surface.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.separated(
                          itemBuilder: (context, index) => ActivityItem(
                            archiveLoan: state.data[archiveLoansDataKey][index],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: state.data[archiveLoansDataKey].length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _UserPage extends StatelessWidget {
  const _UserPage();

  @override
  Widget build(BuildContext context) {
    final archiveCubit = context.read<ArchiveCubit>();
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ArchiveCubit, ArchiveState>(
          bloc: archiveCubit
            ..getArchiveLoansByUser(userId: '${authCubit.userProfile.id}'),
          buildWhen: (previous, current) => current is GetArchiveLoans,
          builder: (context, state) {
            if (state is GetArchiveLoansLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetArchiveLoansLoaded) {
              return Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Cari',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => ReturnArchiveItem(
                          archiveLoan: state.archiveLoans[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: state.archiveLoans.length,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
