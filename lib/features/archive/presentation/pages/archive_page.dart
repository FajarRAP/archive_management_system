import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/constants.dart';
import '../widgets/archive_item.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Arsip')),
      body: ListView.separated(
        itemBuilder: (context, index) => ArchiveItem(index: index),
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        itemCount: 10,
        padding: const EdgeInsets.all(8),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(addArchiveRoute),
        backgroundColor: colorScheme.surfaceTint,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
