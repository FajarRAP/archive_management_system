import 'package:archive_management_system/features/archive/presentation/cubit/archive_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/constants.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

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
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.25,
                        children: [
                          _buildStatCard(
                            title: 'Total Peminjaman',
                            value: '${state.data[archiveLoansTotalKey]}',
                            icon: Icons.book_rounded,
                            colorScheme: colorScheme,
                          ),
                          _buildStatCard(
                            title: 'Arsip Dipinjam',
                            value: '${state.data[archiveLoansCountKey]}',
                            icon: Icons.inventory_2_rounded,
                            colorScheme: colorScheme,
                          ),
                          _buildStatCard(
                            title: 'Belum Dikembalikan',
                            value:
                                '${state.data[archiveLoansNotReturnedCountKey]}',
                            icon: Icons.pending_actions_rounded,
                            colorScheme: colorScheme,
                          ),
                          _buildStatCard(
                            title: 'Total Arsip',
                            value: '${state.data[archivesCountKey]}',
                            icon: Icons.archive_rounded,
                            colorScheme: colorScheme,
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
                        color: colorScheme.surfaceVariant.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return _buildActivityItem(
                              title: 'Peminjaman Arsip #A12345',
                              subtitle: 'Diajukan oleh John Doe',
                              time: '2 jam yang lalu',
                              icon: Icons.book_rounded,
                              colorScheme: colorScheme,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
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

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required ColorScheme colorScheme,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: cardBoxShadow,
        color: colorScheme.surface,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: colorScheme.primary, size: 20),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required ColorScheme colorScheme,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: cardBoxShadow,
        color: colorScheme.surface,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: colorScheme.primary),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(subtitle),
            const SizedBox(height: 4),
            Text(time, style: TextStyle(fontSize: 12)),
          ],
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () {
            // Navigate to detail
          },
        ),
      ),
    );
  }
}
