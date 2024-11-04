import 'package:flutter/material.dart';

import '../../../../core/common/constants.dart';
import '../widgets/menu_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hai, Admin!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
              color: Colors.grey[300],
              child: const Center(
                child: Text(
                  'Carousel Placeholder',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 32,
                  childAspectRatio: 2.5,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: const [
                    MenuButton(
                      title: 'Arsip',
                      icon: Icons.archive,
                      route: archiveRoute,
                    ),
                    MenuButton(
                      title: 'Peminjaman',
                      icon: Icons.assignment,
                      route: archiveRoute,
                    ),
                    MenuButton(
                      title: 'Pengembalian',
                      icon: Icons.assignment_return,
                      route: returnArchiveRoute,
                    ),
                    MenuButton(
                      title: 'Laporan',
                      icon: Icons.bar_chart,
                      route: archiveRoute,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
