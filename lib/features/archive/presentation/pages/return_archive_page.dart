import 'package:flutter/material.dart';

import '../widgets/return_archive_item.dart';

class ReturnArchivePage extends StatelessWidget {
  const ReturnArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengembalian')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => const ReturnArchiveItem(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
