import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/archive_cubit.dart';
import '../widgets/return_archive_item.dart';
import '../widgets/text_badge.dart';

class LendHistoryPage extends StatelessWidget {
  const LendHistoryPage({super.key});

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

class LendHistoryItem extends StatelessWidget {
  const LendHistoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nomor Pinjam'),
              Text('Nomor Arsip/Kelurahan'),
              Text('Tanggal Pinjam'),
              Text('Keterangan'),
            ],
          ),
          TextBadge(
            text: 'Tersedia',
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
