import '../../../auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/helpers/helpers.dart';
import '../../domain/entities/archive_loan_entity.dart';
import 'archive_item_info.dart';
import 'return_archive_confirmation_dialog.dart';

class ReturnArchiveItem extends StatelessWidget {
  const ReturnArchiveItem({
    super.key,
    required this.archiveLoan,
  });

  final ArchiveLoanEntity archiveLoan;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('dd MMMM yyyy');

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: cardBoxShadow,
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No Pinjam : ${archiveLoan.archiveLoanId}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                buildTextBadgeArchiveLoan(archiveLoan),
              ],
            ),
            const SizedBox(height: 16),
            ArchiveItemInfo(
              icon: Icons.folder_outlined,
              label: 'Nomor Arsip',
              value: '${archiveLoan.archive.archiveNumber}',
            ),
            const SizedBox(height: 8),
            ArchiveItemInfo(
              icon: Icons.calendar_today_outlined,
              label: 'Tanggal Pinjam',
              value: dateFormat.format(archiveLoan.borrowedDate),
            ),
            const SizedBox(height: 8),
            ArchiveItemInfo(
              icon: Icons.description_outlined,
              label: 'Keterangan',
              value: archiveLoan.description,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (archiveLoan.returnedAt == null &&
                    (authCubit.user?.userMetadata?['is_admin'] ?? false))
                  TextButton.icon(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) =>
                            ReturnConfirmationDialog(archiveLoan: archiveLoan)),
                    icon: const Icon(Icons.unarchive_outlined),
                    label: const Text('Kembali'),
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                    ),
                  ),
                if (archiveLoan.returnedAt != null ||
                    !(authCubit.user?.userMetadata?['is_admin'] ?? true))
                  const Spacer(),
                TextButton.icon(
                  onPressed: () => context.push(returnArchiveDetailRoute,
                      extra: archiveLoan),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Lihat Detail'),
                  style: TextButton.styleFrom(foregroundColor: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
