import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/constants.dart';
import 'core/routes/router.dart';
import 'dependency_injection.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.get('SUPA_URL'),
    anonKey: dotenv.get('SUPA_KEY'),
  );
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<AuthCubit>()),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: rootScaffoldMessengerState,
        theme: ThemeData(
          primaryColor: const Color(0xFF7ED4AD),
          colorScheme: ColorScheme.fromSeed(
            primary: const Color(0xFF7ED4AD),
            secondary: const Color(0xFFD76C82),
            seedColor: const Color(0xFF7ED4AD),
            tertiary: const Color(0xFF3D0301),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}

// class ArsipPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cari Arsip'),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Nomor Arsip',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Kecamatan',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Kelurahan',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('Cari'),
//               style: ElevatedButton.styleFrom(
//                   // primary: Theme.of(context).accentColor,
//                   ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: DataTable(
//                 columns: [
//                   DataColumn(label: Text('No Arsip')),
//                   DataColumn(label: Text('Kecamatan')),
//                   DataColumn(label: Text('Kelurahan')),
//                   DataColumn(label: Text('Status')),
//                 ],
//                 rows: [
//                   DataRow(cells: [
//                     DataCell(Text('123456')),
//                     DataCell(Text('Pontianak Barat')),
//                     DataCell(Text('Sungai')),
//                     DataCell(TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => CrudArsipPage()),
//                         );
//                       },
//                       child: Text('Edit'),
//                     )),
//                   ]),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CrudArsipPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Data Arsip'),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Nomor Arsip',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Kecamatan',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Kelurahan',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Status',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('Edit'),
//                   style: ElevatedButton.styleFrom(
//                       // primary: Theme.of(context).accentColor,
//                       ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('Hapus'),
//                   style: ElevatedButton.styleFrom(
//                       // primary: Colors.redAccent,
//                       ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('Simpan'),
//                   style: ElevatedButton.styleFrom(
//                       // primary: Theme.of(context).primaryColor,
//                       ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
