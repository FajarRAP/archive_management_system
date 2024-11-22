import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/constants.dart';
import '../cubit/archive_cubit.dart';

class ArchiveFilterSection extends StatelessWidget {
  const ArchiveFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final archiveCubit = context.read<ArchiveCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: cardBoxShadow,
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter Arsip',
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<ArchiveCubit, ArchiveState>(
            buildWhen: (previous, current) => current is GetArchive,
            builder: (context, state) {
              return Column(
                children: [
                  DropdownButtonFormField<String>(
                    onChanged: (value) {
                      if (value != null) archiveCubit.setSubdistrict(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Kecamatan',
                      label: const Text('Kecamatan'),
                      prefixIcon: const Icon(Icons.location_city_rounded),
                    ),
                    value: archiveCubit.getSubdistrict,
                    items: subdistrictsAndUrban.entries
                        .map((subdistrict) => DropdownMenuItem<String>(
                            value: subdistrict.key,
                            child: Text(subdistrict.key)))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    onChanged: (value) {
                      if (value != null) archiveCubit.setUrban(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Kelurahan',
                      label: const Text('Kelurahan'),
                      prefixIcon: const Icon(Icons.apartment_rounded),
                    ),
                    value: archiveCubit.getUrban,
                    items: (archiveCubit.getSubdistrict == null ||
                            archiveCubit.getSubdistrict!.isEmpty)
                        ? []
                        : subdistrictsAndUrban[archiveCubit.getSubdistrict]!
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                      onPressed: archiveCubit.resetFilter,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Reset Filter'),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
