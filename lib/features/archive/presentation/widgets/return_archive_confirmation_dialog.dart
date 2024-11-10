import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/archive_loan_entity.dart';
import 'archive_item_info.dart';

class ReturnConfirmationDialog extends StatelessWidget {
  const ReturnConfirmationDialog({
    super.key,
    required this.archiveLoan,
  });

  final ArchiveLoanEntity archiveLoan;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.2),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.unarchive_rounded,
                      color: colorScheme.onPrimary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Konfirmasi Pengembalian',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArchiveItemInfo(
                    icon: Icons.folder_outlined,
                    label: 'Nomor Arsip',
                    value: '${archiveLoan.archive.archiveNumber}',
                  ),
                  const SizedBox(height: 12),
                  ArchiveItemInfo(
                    icon: Icons.location_city_rounded,
                    label: 'Kecamatan',
                    value: archiveLoan.archive.subdistrict,
                  ),
                  const SizedBox(height: 12),
                  ArchiveItemInfo(
                    icon: Icons.apartment_rounded,
                    label: 'Kelurahan',
                    value: archiveLoan.archive.urban,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Apakah Anda yakin ingin mengembalikan arsip ini?',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: context.pop,
                icon: const Icon(Icons.close_rounded),
                label: const Text('Batal'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  side: BorderSide(color: colorScheme.outline),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check_rounded),
                label: const Text('Konfirmasi'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
