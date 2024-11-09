import 'package:flutter/material.dart';

import '../../../../core/common/constants.dart';

class ArchiveFilterSection extends StatefulWidget {
  const ArchiveFilterSection({super.key});

  @override
  State<ArchiveFilterSection> createState() => _ArchiveFilterSectionState();
}

class _ArchiveFilterSectionState extends State<ArchiveFilterSection> {
  String? selectedSubdistrict;
  String? selectedUrban;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: cardBoxShadow,
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter Arsip',
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              DropdownButtonFormField(
                onChanged: (value) {
                  if (value != selectedSubdistrict) selectedUrban = null;
                  setState(() => selectedSubdistrict = value);
                },
                decoration: InputDecoration(
                  hintText: 'Kecamatan',
                  label: const Text('Kecamatan'),
                  prefixIcon: Icon(
                    Icons.location_city_rounded,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                ),
                value: selectedSubdistrict,
                items: subdistrictsAndUrban.entries
                    .map((subdistrict) => DropdownMenuItem<String>(
                        value: subdistrict.key, child: Text(subdistrict.key)))
                    .toList(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                onChanged: (value) => setState(() => selectedUrban = value),
                decoration: InputDecoration(
                  hintText: 'Kelurahan',
                  label: const Text('Kelurahan'),
                  prefixIcon: Icon(
                    Icons.apartment_rounded,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                ),
                value: selectedUrban,
                items: _items(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _items() {
    if (selectedSubdistrict == null || selectedSubdistrict!.isEmpty) return [];

    return subdistrictsAndUrban[selectedSubdistrict]!
        .map((urban) =>
            DropdownMenuItem<String>(value: urban, child: Text(urban)))
        .toList();
  }
}
