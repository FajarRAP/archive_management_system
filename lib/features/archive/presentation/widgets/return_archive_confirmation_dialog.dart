import 'package:archive_management_system/core/common/snack_bar.dart';
import 'package:archive_management_system/features/archive/presentation/cubit/archive_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final archiveCubit = context.read<ArchiveCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: context.pop,
                icon: const Icon(Icons.close_rounded),
                label: const Text(
                  'Batal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size.fromHeight(48),
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BlocConsumer<ArchiveCubit, ArchiveState>(
                buildWhen: (previous, current) =>
                    current is ReturnBorrowedArchive,
                listener: (context, state) {
                  if (state is ReturnBorrowedArchiveError) {
                    showSnackBar(message: state.message);
                  }

                  if (state is ReturnBorrowedArchiveLoaded) {
                    context.pop();
                    archiveCubit.getArchiveLoans();
                    showSnackBar(message: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is ReturnBorrowedArchiveLoading) {
                    return FilledButton(
                      onPressed: null,
                      style: FilledButton.styleFrom(
                        fixedSize: Size.fromHeight(48),
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  }

                  return FilledButton.icon(
                    onPressed: () async => await archiveCubit
                        .returnBorrowedArchive(archiveLoan: archiveLoan),
                    icon: const Icon(Icons.check_rounded),
                    label: const Text(
                      'Konfirmasi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: FilledButton.styleFrom(
                      fixedSize: Size.fromHeight(48),
                      padding: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
      content: Column(
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
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
