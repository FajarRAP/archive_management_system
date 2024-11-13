import 'package:flutter/material.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/helpers/helpers.dart';
import '../../domain/entities/archive_loan_entity.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    super.key,
    required this.archiveLoan,
  });

  final ArchiveLoanEntity archiveLoan;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: cardBoxShadow,
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(Icons.book_rounded, color: colorScheme.primary),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Dipinjam oleh ${archiveLoan.profile.name}'),
            const SizedBox(height: 4),
            Text(
              convertTimeAgo(archiveLoan.borrowedDate),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        title: Text(
          'Peminjaman Arsip #${archiveLoan.archive.archiveNumber}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
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
