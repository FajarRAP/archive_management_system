import 'package:archive_management_system/features/archive/presentation/widgets/archive_item_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/common/constants.dart';
import '../../../../dependency_injection.dart';
import '../../domain/entities/archive_entity.dart';
import 'text_badge.dart';

class ArchiveItem extends StatelessWidget {
  const ArchiveItem({
    super.key,
    required this.archive,
  });

  final ArchiveEntity archive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final user = getIt.get<SupabaseClient>().auth.currentUser;
    late Widget textBadge;

    switch (archive.status) {
      case availableStatus:
        textBadge = TextBadge(color: Colors.green, text: availableStatus);
        break;
      case borrowedStatus:
        textBadge = TextBadge(color: Colors.red, text: borrowedStatus);
        break;
      case lostStatus:
        textBadge = TextBadge(color: Colors.grey, text: lostStatus);
        break;
      default:
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: cardBoxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceTint.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.archive_rounded,
                    color: colorScheme.surfaceTint,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nomor Arsip: ${archive.archiveNumber}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      textBadge
                    ],
                  ),
                ),
                if (user?.userMetadata?['is_admin'])
                  IconButton(
                    icon: Icon(Icons.edit_rounded, color: colorScheme.primary),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.primary.withOpacity(0.1),
                    ),
                    onPressed: () => context.push(
                      '$archiveRoute/${archive.archiveNumber}',
                      extra: archive,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            ArchiveItemInfo(
              icon: Icons.location_city_rounded,
              label: 'Kecamatan',
              value: archive.subdistrict,
            ),
            const SizedBox(height: 8),
            ArchiveItemInfo(
              icon: Icons.apartment_rounded,
              label: 'Kelurahan',
              value: archive.urban,
            ),
            const SizedBox(height: 12),
            if (!user?.userMetadata?['is_admin'])
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () =>
                        context.push(borrowArchiveRoute, extra: archive),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Pinjam Arsip'),
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
