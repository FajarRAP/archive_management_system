import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/constants.dart';
import 'text_badge.dart';

class ArchiveItem extends StatelessWidget {
  const ArchiveItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEvenIndex = index % 2 == 0;
    late Widget textBadge;

    if (isEvenIndex) {
      textBadge = const TextBadge(text: 'Tersedia', color: Colors.green);
    } else {
      textBadge = const TextBadge(text: 'Habis', color: Colors.red);
    }

    return Card(
      child: ListTile(
        leading: Icon(Icons.archive, color: colorScheme.surfaceTint),
        title: Text(
          'Nomor Arsip: $index',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Kecamatan : BOKEP'),
            const SizedBox(height: 4),
            const Text('Kelurahan : KONTOL'),
            const SizedBox(height: 4),
            textBadge,
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.grey),
          onPressed: () => context.push('$archiveRoute/$index'),
        ),
      ),
    );
  }
}
