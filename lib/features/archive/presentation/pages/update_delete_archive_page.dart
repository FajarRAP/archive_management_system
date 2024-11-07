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
  late final TextEditingController _archiveController;
  late final TextEditingController _subdistrictController;
  late final TextEditingController _urbanController;
  late String _archiveStatus;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _archiveController =
        TextEditingController(text: '${widget.archive.archiveNumber}');
    _subdistrictController =
        TextEditingController(text: widget.archive.subdistrict);
    _urbanController = TextEditingController(text: widget.archive.urban);
    _archiveStatus = widget.archive.status;
    super.initState();
  }

  @override
  void dispose() {
    _archiveController.dispose();
    _subdistrictController.dispose();
    _urbanController.dispose();
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
                content: const Text(
                  'Apakah anda yakin ingin menghapus arsip nomor xxx?',
                  style: TextStyle(fontSize: 16),
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
                        return showSnackBar(message: state.message);
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: (state is DeleteArchiveLoading)
                            ? null
                            : () async {
                                await archiveCubit.deleteArchive(
                                  archiveId: '${widget.archive.archiveId}',
                                );

                                if (!context.mounted) return;

                                context.pushReplacement(archiveRoute);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.error,
                          foregroundColor: Colors.white,
                        ),
                        child: BlocBuilder<ArchiveCubit, ArchiveState>(
                          buildWhen: (previous, current) =>
                              current is DeleteArchive,
                          builder: (context, state) {
                            if (state is DeleteArchiveLoading) {
                              return CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              );
                            }

                            return const Text('Hapus');
                          },
                        ),
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
                          prefixIcon: Icon(Icons.numbers_rounded),
                        ),
                        readOnly: true,
                        validator: validate,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _subdistrictController,
                        decoration: InputDecoration(
                          labelText: 'Kecamatan',
                          hintText: 'Masukkan nama kecamatan',
                          prefixIcon: Icon(Icons.location_city_rounded),
                        ),
                        validator: validate,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _urbanController,
                        decoration: InputDecoration(
                          labelText: 'Kelurahan',
                          hintText: 'Masukkan nama kelurahan',
                          prefixIcon: Icon(Icons.apartment_rounded),
                        ),
                        validator: validate,
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        onChanged: (value) => _archiveStatus = value ?? '',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: statusOptions.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          label: const Text('Status Arsip'),
                          hintText: 'Pilih status',
                          prefixIcon: Icon(Icons.inventory_2_rounded),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
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
                      return ElevatedButton(
                        onPressed: (state is UpdateArchiveLoading)
                            ? null
                            : () async {
                                if (!_formKey.currentState!.validate()) return;

                                final archiveNumber =
                                    int.parse(_archiveController.text.trim());
                                final subdistrict =
                                    _subdistrictController.text.trim();
                                final urban = _urbanController.text.trim();
                                final archive = ArchiveEntity(
                                    archiveId: widget.archive.archiveId,
                                    archiveNumber: archiveNumber,
                                    subdistrict: subdistrict,
                                    urban: urban,
                                    status: _archiveStatus);

                                await archiveCubit.updateArchive(
                                    archive: archive);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          elevation: 2,
                          foregroundColor: Colors.white,
                        ),
                        child: BlocBuilder<ArchiveCubit, ArchiveState>(
                          buildWhen: (previous, current) =>
                              current is UpdateArchive,
                          builder: (context, state) {
                            if (state is UpdateArchiveLoading) {
                              return CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              );
                            }

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.edit_rounded),
                                SizedBox(width: 8),
                                Text(
                                  'Simpan Perubahan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            );
                          },
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
}
