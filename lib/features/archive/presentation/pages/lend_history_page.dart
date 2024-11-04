import 'package:flutter/material.dart';

import '../widgets/text_badge.dart';

class LendHistoryPage extends StatelessWidget {
  const LendHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => const LendHistoryItem(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class LendHistoryItem extends StatelessWidget {
  const LendHistoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nomor Pinjam'),
              Text('Nomor Arsip/Kelurahan'),
              Text('Tanggal Pinjam'),
              Text('Keterangan'),
            ],
          ),
          TextBadge(
            text: 'Tersedia',
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
