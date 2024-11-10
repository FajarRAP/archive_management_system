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
  final _subdistrictController = TextEditingController();
  final _urbanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var archiveStatus = '';

  @override
  void dispose() {
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
                      color: colorScheme.primary,
                      size: 48,
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
                        archiveCubit.getArchive();
                        return showSnackBar(message: state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is InsertArchiveLoading) {
                        return ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: Colors.white,
                            elevation: 2,
                          ),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        );
                      }

                      return ElevatedButton.icon(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;

                          final subdistrict =
                              _subdistrictController.text.trim();
                          final urban = _urbanController.text.trim();
                          final archive = ArchiveEntity(
                              subdistrict: subdistrict,
                              urban: urban,
                              status: archiveStatus);
                          await archiveCubit.insertArchive(archive: archive);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 2,
                        ),
                        icon: Icon(Icons.add_rounded),
                        label: Text(
                          'Tambah Arsip',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
}
