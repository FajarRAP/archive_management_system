import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/common/snack_bar.dart';
import '../../../../core/helpers/validation.dart';
import '../../domain/entities/archive_entity.dart';
import '../cubit/archive_cubit.dart';

class UpdateDeleteArchivePage extends StatefulWidget {
  const UpdateDeleteArchivePage({
    super.key,
    required this.archive,
  });

  final ArchiveEntity archive;

  @override
  State<UpdateDeleteArchivePage> createState() =>
      _UpdateDeleteArchivePageState();
}

class _UpdateDeleteArchivePageState extends State<UpdateDeleteArchivePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _archiveController;
  late String _archiveStatus;
  String? _selectedSubdistrict;
  String? _selectedUrban;

  @override
  void initState() {
    _archiveController =
        TextEditingController(text: '${widget.archive.archiveNumber}');
    _archiveStatus = widget.archive.status;
    _selectedSubdistrict = widget.archive.subdistrict;
    _selectedUrban = widget.archive.urban;
    super.initState();
  }

  @override
  void dispose() {
    _archiveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final archiveCubit = context.read<ArchiveCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Row(
                  children: [
                    Icon(Icons.warning_rounded, color: colorScheme.error),
                    const SizedBox(width: 10),
                    const Text('Hapus Arsip'),
                  ],
                ),
                content: Text(
                  'Apakah anda yakin ingin menghapus arsip nomor ${widget.archive.archiveNumber}?',
                  style: const TextStyle(fontSize: 16),
                ),
                actions: [
                  TextButton(
                    onPressed: context.pop,
                    child: Text(
                      'Batal',
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ),
                  BlocConsumer<ArchiveCubit, ArchiveState>(
                    buildWhen: (previous, current) => current is DeleteArchive,
                    listener: (context, state) {
                      if (state is DeleteArchiveError) {
                        return showSnackBar(message: state.message);
                      }

                      if (state is DeleteArchiveLoaded) {
                        archiveCubit.getArchive();
                        context.pop(); // Pop Dialog
                        context.pop(); // Pop Page
                        return showSnackBar(message: state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is DeleteArchiveLoading) {
                        return ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.error,
                            foregroundColor: Colors.white,
                          ),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () async => await archiveCubit.deleteArchive(
                            archiveId: '${widget.archive.archiveNumber}'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.error,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Hapus'),
                      );
                    },
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
        backgroundColor: colorScheme.primary.withOpacity(0.125),
        title: const Text('Update Arsip'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.archive_rounded,
                      size: 48,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: cardBoxShadow,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Arsip',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _archiveController,
                        decoration: InputDecoration(
                          labelText: 'Nomor Arsip',
                          hintText: 'Masukkan nomor arsip',
                          prefixIcon: const Icon(Icons.numbers_rounded),
                        ),
                        readOnly: true,
                        validator: validate,
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        onChanged: (value) {
                          if (value != _selectedSubdistrict) {
                            _selectedUrban = null;
                          }
                          setState(() => _selectedSubdistrict = value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Kecamatan',
                          label: const Text('Kecamatan'),
                          prefixIcon: const Icon(Icons.location_city_rounded),
                        ),
                        value: _selectedSubdistrict,
                        items: subdistrictsAndUrban.entries
                            .map((subdistrict) => DropdownMenuItem<String>(
                                value: subdistrict.key,
                                child: Text(subdistrict.key)))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        onChanged: (value) =>
                            setState(() => _selectedUrban = value),
                        decoration: InputDecoration(
                          hintText: 'Kelurahan',
                          label: const Text('Kelurahan'),
                          prefixIcon: const Icon(Icons.apartment_rounded),
                        ),
                        value: _selectedUrban,
                        items: _items(),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        onChanged: (value) => _archiveStatus = '$value',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: statusOptions
                            .map((status) => DropdownMenuItem<String>(
                                value: status, child: Text(status)))
                            .toList(),
                        decoration: InputDecoration(
                          label: const Text('Status Arsip'),
                          hintText: 'Pilih status',
                          prefixIcon: const Icon(Icons.inventory_2_rounded),
                        ),
                        validator: validate,
                        value: _archiveStatus,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: BlocConsumer<ArchiveCubit, ArchiveState>(
                    buildWhen: (previous, current) => current is UpdateArchive,
                    listener: (context, state) {
                      if (state is UpdateArchiveError) {
                        return showSnackBar(message: state.message);
                      }

                      if (state is UpdateArchiveLoaded) {
                        archiveCubit.getArchive();
                        return showSnackBar(message: state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdateArchiveLoading) {
                        return FilledButton(
                          onPressed: null,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        );
                      }

                      return FilledButton.icon(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;

                          final archive = ArchiveEntity(
                              archiveNumber: widget.archive.archiveNumber,
                              subdistrict: _selectedSubdistrict!,
                              urban: _selectedUrban!,
                              status: _archiveStatus);

                          await archiveCubit.updateArchive(archive: archive);
                        },
                        style: FilledButton.styleFrom(elevation: 2),
                        icon: const Icon(Icons.edit_rounded),
                        label: const Text(
                          'Simpan Perubahan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _items() {
    if (_selectedSubdistrict == null || _selectedSubdistrict!.isEmpty) {
      return [];
    }

    return subdistrictsAndUrban[_selectedSubdistrict]!
        .map((urban) =>
            DropdownMenuItem<String>(value: urban, child: Text(urban)))
        .toList();
  }
}
