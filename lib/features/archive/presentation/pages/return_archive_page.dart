import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/archive_cubit.dart';
import '../widgets/return_archive_item.dart';

class ReturnArchivePage extends StatefulWidget {
  const ReturnArchivePage({super.key});

  @override
  State<ReturnArchivePage> createState() => _ReturnArchivePageState();
}

class _ReturnArchivePageState extends State<ReturnArchivePage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final archiveCubit = context.read<ArchiveCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Pengembalian')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ArchiveCubit, ArchiveState>(
          bloc: archiveCubit..getNotReturnedArchiveLoans(),
          buildWhen: (previous, current) => current is GetArchiveLoans,
          builder: (context, state) {
            if (state is GetArchiveLoansLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetArchiveLoansLoaded) {
              return RefreshIndicator(
                onRefresh: archiveCubit.getNotReturnedArchiveLoans,
                displacement: 10,
                child: Column(
                  children: [
                    TextField(
                      onChanged: archiveCubit.searchArchiveLoans,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Cari',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(child: _buildArchiveLoanList()),
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

  Widget _buildArchiveLoanList() {
    final archiveCubit = context.read<ArchiveCubit>();

    if (archiveCubit.archiveLoans.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada peminjaman arsip',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    if (_controller.text.isNotEmpty && archiveCubit.results.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada hasil',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        if (_controller.text.isEmpty) {
          return ReturnArchiveItem(
              archiveLoan: archiveCubit.archiveLoans[index]);
        }

        return ReturnArchiveItem(archiveLoan: archiveCubit.results[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: _controller.text.isEmpty
          ? archiveCubit.archiveLoans.length
          : archiveCubit.results.length,
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}
