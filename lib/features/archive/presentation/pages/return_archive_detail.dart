import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/helpers/helpers.dart';
import '../../domain/entities/archive_loan_entity.dart';
import '../widgets/archive_detail_item_info.dart';

class ReturnArchiveDetail extends StatelessWidget {
  const ReturnArchiveDetail({
    super.key,
    required this.archiveLoan,
  });

  final ArchiveLoanEntity archiveLoan;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('dd MMMM yyyy');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: const Text(
          'Detail Pengembalian',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              color: colorScheme.primary,
            ),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              children: [
                const Icon(
                  Icons.assignment_return_rounded,
                  size: 60,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  '${archiveLoan.archiveLoanId}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                buildTextBadge(archiveLoan.archive.status),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailSection(
                  title: 'Informasi Arsip',
                  children: [
                    ArchiveDetailItemInfo(
                      icon: Icons.folder_outlined,
                      label: 'Nomor Arsip',
                      value: '${archiveLoan.archive.archiveNumber}',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _DetailSection(
                  title: 'Informasi Peminjaman',
                  children: [
                    ArchiveDetailItemInfo(
                      icon: Icons.calendar_today_outlined,
                      label: 'Tanggal Pinjam',
                      value: dateFormat.format(archiveLoan.borrowedDate),
                    ),
                    const SizedBox(height: 12),
                    ArchiveDetailItemInfo(
                      icon: Icons.event,
                      label: 'Tanggal Kembali',
                      value: archiveLoan.returnedAt == null
                          ? '-'
                          : dateFormat.format(archiveLoan.returnedAt!),
                    ),
                    const SizedBox(height: 12),
                    ArchiveDetailItemInfo(
                      icon: Icons.timer_outlined,
                      label: 'Durasi Peminjaman',
                      value: archiveLoan.returnedAt == null
                          ? '-'
                          : '${archiveLoan.returnedAt?.difference(archiveLoan.borrowedDate).inDays} Hari',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _DetailSection(
                  title: 'Informasi Peminjam',
                  children: [
                    ArchiveDetailItemInfo(
                      icon: Icons.person_outline,
                      label: 'Nama Peminjam',
                      value: archiveLoan.profile.name,
                    ),
                    const SizedBox(height: 12),
                    ArchiveDetailItemInfo(
                      icon: Icons.work,
                      label: 'Jabatan',
                      value: archiveLoan.profile.jobTitle,
                    ),
                    const SizedBox(height: 12),
                    ArchiveDetailItemInfo(
                      icon: Icons.description_outlined,
                      label: 'Keterangan',
                      value: archiveLoan.description,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: cardBoxShadow,
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(children: children),
        ),
      ],
    );
  }
}
