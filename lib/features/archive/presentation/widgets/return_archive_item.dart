import 'package:archive_management_system/features/archive/presentation/widgets/text_badge.dart';
import 'package:flutter/material.dart';

class ReturnArchiveItem extends StatelessWidget {
  const ReturnArchiveItem({
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
          TextBadge(text: 'Dikembalikan', color: Colors.green),
        ],
      ),
    );
  }
}
