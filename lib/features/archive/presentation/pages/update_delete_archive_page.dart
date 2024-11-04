import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/helpers/validation.dart';

class UpdateDeleteArchivePage extends StatefulWidget {
  const UpdateDeleteArchivePage({super.key});

  @override
  State<UpdateDeleteArchivePage> createState() =>
      _UpdateDeleteArchivePageState();
}

class _UpdateDeleteArchivePageState extends State<UpdateDeleteArchivePage> {
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
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Hapus'),
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
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) return;

                            setState(() => _isLoading = true);
                            await Future.delayed(const Duration(seconds: 2));
                            setState(() => _isLoading = false);
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
