import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateDeleteArchivePage extends StatelessWidget {
  const UpdateDeleteArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Arsip'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.surfaceTint,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Hapus Arsip'),
                content: const Text(
                    'Apakah anda yakin ingin menghapus arsip nomor xxx?'),
                actions: [
                  TextButton(
                    onPressed: context.pop,
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Hapus'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Nomor Arsip'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Kecamatan'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Kelurahan'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
