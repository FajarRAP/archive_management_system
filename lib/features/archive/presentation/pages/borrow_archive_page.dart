import '../../../../core/common/snack_bar.dart';
import '../../domain/entities/archive_loan_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/helpers/validation.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../domain/entities/archive_entity.dart';
import '../cubit/archive_cubit.dart';
import '../widgets/archive_item_info.dart';

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
  late final TextEditingController _descriptionController;
  late final TextEditingController _datePickerController;
  var datePicked = DateTime.now();

  @override
  void initState() {
    _descriptionController = TextEditingController();
    _datePickerController = TextEditingController(
      text: dateFormat.format(DateTime.now()),
    );
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _datePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final archiveCubit = context.read<ArchiveCubit>();
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
                    'Informasi Arsip',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ArchiveItemInfo(
                    icon: Icons.numbers_rounded,
                    label: 'Nomor Arsip',
                    value: '${widget.archive.archiveNumber}',
                  ),
                  const SizedBox(height: 8),
                  ArchiveItemInfo(
                    icon: Icons.location_city_rounded,
                    label: 'Kecamatan',
                    value: widget.archive.subdistrict,
                  ),
                  const SizedBox(height: 8),
                  ArchiveItemInfo(
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
            BlocConsumer<ArchiveCubit, ArchiveState>(
              buildWhen: (previous, current) => current is BorrowArchive,
              listener: (context, state) {
                if (state is BorrowArchiveError) {
                  showSnackBar(message: state.message);
                }

                if (state is BorrowArchiveLoaded) {
                  context.pop();
                  archiveCubit.getArchive();
                  showSnackBar(message: state.message);
                }
              },
              builder: (context, state) {
                if (state is BorrowArchiveLoading) {
                  return FilledButton.icon(
                    onPressed: null,
                    label: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  );
                }
                return FilledButton.icon(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final archiveLoan = ArchiveLoanEntity(
                        archive: widget.archive,
                        profile: authCubit.userProfile,
                        description: _descriptionController.text.trim(),
                        borrowedDate: datePicked);

                    await archiveCubit.borrowArchive(archiveLoan: archiveLoan);
                  },
                  icon: const Icon(Icons.check_rounded),
                  label: const Text(
                    'Ajukan Peminjaman',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                );
              },
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
          controller: _descriptionController,
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
              datePicked = date;
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
}
