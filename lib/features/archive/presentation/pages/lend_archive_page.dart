import 'package:flutter/material.dart';

class LendArchivePage extends StatefulWidget {
  const LendArchivePage({super.key});

  @override
  State<LendArchivePage> createState() => _LendArchivePageState();
}

class _LendArchivePageState extends State<LendArchivePage> {
  final ciamis = ['Kawali', 'Kawalimukti', 'Linggapura'];
  final bantul = ['Banguntapan', 'Tamanan', 'Potorono'];
  final dataset = {

  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Expanded(child: Text('Kabupaten')),
                Expanded(
                  flex: 2,
                  child: DropdownButton(
                    isExpanded: true,
                    items: const <DropdownMenuItem>[
                      DropdownMenuItem(
                        value: 0,
                        child: Text('Item 1'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
