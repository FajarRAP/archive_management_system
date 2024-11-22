import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

import '../../../../core/common/constants.dart';
import '../../../../core/common/snack_bar.dart';
import '../../../../dependency_injection.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../domain/entities/archive_loan_entity.dart';
import '../cubit/archive_cubit.dart';
import '../widgets/activity_item.dart';
import '../widgets/return_archive_item.dart';
import '../widgets/statistics_card.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = getIt.get<s.SupabaseClient>();
    final userMetadata = supabase.auth.currentUser?.userMetadata;
    final bool isAdmin = userMetadata?['is_admin'] ?? false;

    return isAdmin ? const _AdminPage() : const _UserPage();
  }
}

class _AdminPage extends StatelessWidget {
  const _AdminPage();

  @override
  Widget build(BuildContext context) {
    final archiveCubit = context.read<ArchiveCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<ArchiveCubit, ArchiveState>(
      listenWhen: (previous, current) => current is DownloadArchiveReport,
      listener: (context, state) {
        if (state is DownloadArchiveReportLoaded) {
          return showSnackBar(message: state.message);
        }

        if (state is DownloadArchiveReportError) {
          return showSnackBar(message: state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<ArchiveCubit, ArchiveState>(
              buildWhen: (previous, current) => current is GetArchiveStatistics,
              builder: (context, state) {
                if (state is GetArchiveStatisticsLoaded) {
                  return IconButton(
                    onPressed: () async {
                      await Permission.manageExternalStorage
                          .onDeniedCallback(() async =>
                              await Permission.manageExternalStorage.request())
                          .request();

                      final List<ArchiveLoanEntity> archiveLoans =
                          state.data[archiveLoansDataKey];

                      await archiveCubit.downloadArchiveReport(
                          archiveLoans: archiveLoans);
                    },
                    tooltip: 'Unduh Laporan',
                    icon: const Icon(Icons.download_rounded),
                  );
                }

                return const SizedBox();
              },
            )
          ],
          title: const Text('Laporan'),
        ),
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
                              archiveLoan: state.data[archiveLoansDataKey]
                                  [index],
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
      ),
    );
  }
}

class _UserPage extends StatefulWidget {
  const _UserPage();

  @override
  State<_UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<_UserPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      onChanged: archiveCubit.searchArchiveLoans,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Cari',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(child: _buildArchiveLoanList()),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildArchiveLoanList() {
    final archiveCubit = context.read<ArchiveCubit>();
    final authCubit = context.read<AuthCubit>();

    if (_controller.text.isNotEmpty && archiveCubit.results.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada hasil',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => archiveCubit.getArchiveLoansByUser(
          userId: '${authCubit.userProfile.id}'),
      displacement: 10,
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (_controller.text.isEmpty) {
            return ReturnArchiveItem(
              archiveLoan: archiveCubit.archiveLoans[index],
            );
          }

          return ReturnArchiveItem(
            archiveLoan: archiveCubit.results[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: _controller.text.isEmpty
            ? archiveCubit.archiveLoans.length
            : archiveCubit.results.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
