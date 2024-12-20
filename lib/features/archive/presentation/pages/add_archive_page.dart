import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/common/snack_bar.dart';
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
  String? _selectedSubdistrict;
  String? _selectedUrban;

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
                      color: colorScheme.primary.withOpacity(0.15),
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
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        onChanged: (value) => archiveStatus = '$value',
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

                          if (_selectedSubdistrict == null ||
                              _selectedSubdistrict!.isEmpty) return;
                          if (_selectedUrban == null ||
                              _selectedUrban!.isEmpty) {
                            return;
                          }

                          final archive = ArchiveEntity(
                              subdistrict: _selectedSubdistrict!,
                              urban: _selectedUrban!,
                              status: archiveStatus);
                          await archiveCubit.insertArchive(archive: archive);
                        },
                        style: FilledButton.styleFrom(elevation: 2),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text(
                          'Tambah Arsip',
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
