import 'package:archive_management_system/dependency_injection.dart';
import 'package:archive_management_system/features/archive/data/datasources/archive_remote_data_source.dart';
import 'package:archive_management_system/features/archive/domain/entities/archive_entity.dart';
import 'package:archive_management_system/features/archive/domain/repositories/archive_repositories.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/helpers/validation.dart';

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
  var _isLoading = false;

  @override
  void dispose() {
    _archiveController.dispose();
    _subdistrictController.dispose();
    _urbanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const statusOptions = ['Tersedia', 'Dipinjam', 'Hilang'];

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
                        onChanged: (value) {},
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
                  child: ElevatedButton(
                    // onPressed: _isLoading
                    //     ? null
                    //     : () async {
                    //         if (!_formKey.currentState!.validate()) return;

                    //         setState(() => _isLoading = true);
                    //         await Future.delayed(const Duration(seconds: 2));
                    //         setState(() => _isLoading = false);
                    //       },
                    onPressed: () async {
                      final data =
                          await getIt.get<ArchiveRepositories>().insertArchive(
                                ArchiveEntity(
                                    archiveNumber: 2,
                                    subdistrict: 'Kawali',
                                    urban: 'Linggapura',
                                    status: 'Tersedia')
                              );
                      print(data);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add_rounded),
                              SizedBox(width: 8),
                              Text(
                                'Tambah Arsip',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
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
