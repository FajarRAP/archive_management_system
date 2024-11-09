import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/constants.dart';
import '../cubit/archive_cubit.dart';
import '../widgets/archive_item.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Arsip')),
      body: BlocBuilder<ArchiveCubit, ArchiveState>(
        bloc: context.read<ArchiveCubit>()..getArchive(),
        buildWhen: (previous, current) => current is GetArchive,
        builder: (context, state) {
          if (state is GetArchiveLoading) {
            return const Center(child: CircularProgressIndicator());
          }
      
          if (state is GetArchiveLoaded) {
            return RefreshIndicator(
              onRefresh: context.read<ArchiveCubit>().getArchive,
              displacement: 10,
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    ArchiveItem(archive: state.archives[index]),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: state.archives.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            );
          }
      
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(addArchiveRoute),
        backgroundColor: colorScheme.surfaceTint,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

