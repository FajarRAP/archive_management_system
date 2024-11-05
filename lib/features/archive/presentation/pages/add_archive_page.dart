import 'package:archive_management_system/core/common/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/helpers/validation.dart';
import '../../domain/entities/archive_entity.dart';
import '../cubit/archive_cubit.dart';

class AddArchivePage extends StatefulWidget {
  const AddArchivePage({super.key});

  @override
  State<AddArchivePage> createState() => _AddArchivePageState();
}

class _AddArchivePageState extends State<AddArchivePage> {
  final _archiveController = TextEditingController();
  final _subdistrictController = TextEditingController();
  final _urbanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var archiveStatus = '';

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
    const statusOptions = [availableStatus, borrowedStatus, lostStatus];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary.withOpacity(0.125),
        title: const Text('Tambah Arsip'),
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
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(16),
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
                        keyboardType: TextInputType.number,
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
                        onChanged: (value) => archiveStatus = value ?? '',
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: BlocConsumer<ArchiveCubit, ArchiveState>(
                    buildWhen: (previous, current) => current is InsertArchive,
                    listener: (context, state) {
                      if (state is InsertArchiveError) {
                        return showSnackBar(message: state.message);
                      }
                      if (state is InsertArchiveLoaded) {
                        return showSnackBar(message: state.message);
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: (state is InsertArchiveLoading)
                            ? null
                            : () async {
                                if (!_formKey.currentState!.validate()) return;

                                await archiveCubit.insertArchive(
                                  archive: ArchiveEntity(
                                    archiveNumber: int.parse(
                                        _archiveController.text.trim()),
                                    subdistrict:
                                        _subdistrictController.text.trim(),
                                    urban: _urbanController.text.trim(),
                                    status: archiveStatus,
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 2,
                        ),
                        child: BlocBuilder<ArchiveCubit, ArchiveState>(
                          builder: (context, state) {
                            if (state is InsertArchiveLoading) {
                              return const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              );
                            }

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add_rounded),
                                SizedBox(width: 8),
                                Text(
                                  'Tambah Arsip',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
