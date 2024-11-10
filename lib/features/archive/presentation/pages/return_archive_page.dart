import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/archive_cubit.dart';
import '../widgets/return_archive_item.dart';

class ReturnArchivePage extends StatelessWidget {
  const ReturnArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final archiveCubit = context.read<ArchiveCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Pengembalian')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ArchiveCubit, ArchiveState>(
          bloc: archiveCubit..getArchiveLoans(),
          buildWhen: (previous, current) => current is GetArchiveLoans,
          builder: (context, state) {
            if (state is GetArchiveLoansLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetArchiveLoansLoaded) {
              return RefreshIndicator(
                onRefresh: archiveCubit.getArchiveLoans,
                displacement: 10,
                child: Column(
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
                      ),
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
