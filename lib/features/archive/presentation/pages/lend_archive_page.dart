import 'package:archive_management_system/core/common/constants.dart';
import 'package:archive_management_system/core/helpers/validation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/archive_entity.dart';

class BorrowArchivePage extends StatefulWidget {
  const BorrowArchivePage({
    super.key,
    required this.archive,
  });

  final ArchiveEntity archive;

  @override
  State<BorrowArchivePage> createState() => _BorrowArchivePageState();
}

class _BorrowArchivePageState extends State<BorrowArchivePage> {
  final dateFormat = DateFormat('dd MMMM yyyy');
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _purposeController;
  late final TextEditingController _datePickerController;

  @override
  void initState() {
    _purposeController = TextEditingController();
    _datePickerController = TextEditingController(
      text: dateFormat.format(DateTime.now()),
    );
    super.initState();
  }

  @override
  void dispose() {
    _purposeController.dispose();
    _datePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pinjam Arsip')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: cardBoxShadow,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Arsip',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ItemInfo(
                    icon: Icons.numbers_rounded,
                    label: 'Nomor Arsip',
                    value: '${widget.archive.archiveNumber}',
                  ),
                  const SizedBox(height: 8),
                  _ItemInfo(
                    icon: Icons.location_city_rounded,
                    label: 'Kecamatan',
                    value: widget.archive.subdistrict,
                  ),
                  const SizedBox(height: 8),
                  _ItemInfo(
                    icon: Icons.apartment_rounded,
                    label: 'Kelurahan',
                    value: widget.archive.urban,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildBorrowForm(),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_rounded),
              label: const Text('Ajukan Peminjaman'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBorrowForm() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Peminjaman',
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _purposeController,
          decoration: InputDecoration(
            hintText: 'Keterangan',
            labelText: 'Keterangan',
            prefixIcon: const Icon(Icons.description_rounded),
          ),
          maxLines: 3,
          validator: validate,
        ),
        const SizedBox(height: 16),
        TextFormField(
          onTap: () async {
            final now = DateTime.now();
            final date = await showDatePicker(
              context: context,
              initialDate: now,
              firstDate: now,
              lastDate: now.add(const Duration(days: 30)),
            );

            if (date == null) return;

            setState(() {
              _datePickerController.text = dateFormat.format(date);
            });
          },
          controller: _datePickerController,
          decoration: InputDecoration(
            hintText: 'Tanggal Peminjaman',
            labelText: 'Tanggal Peminjaman',
            prefixIcon: const Icon(Icons.calendar_today_rounded),
          ),
          readOnly: true,
          validator: validate,
        ),
      ],
    );
  }

  // void _submitBorrowRequest() {
  //   if (_formKey.currentState!.validate() && _borrowDate != null) {
  //     // Implement borrow request submission logic here
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Permintaan peminjaman berhasil diajukan'),
  //         behavior: SnackBarBehavior.floating,
  //       ),
  //     );
  //     Navigator.pop(context);
  //   } else if (_borrowDate == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Silakan pilih tanggal peminjaman'),
  //         behavior: SnackBarBehavior.floating,
  //       ),
  //     );
  //   }
  // }
}

class _ItemInfo extends StatelessWidget {
  const _ItemInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value),
      ],
    );
  }
}
