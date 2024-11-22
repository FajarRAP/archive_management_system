import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/constants.dart';
import 'core/routes/router.dart';
import 'core/themes/theme.dart';
import 'dependency_injection.dart';
import 'features/archive/presentation/cubit/archive_cubit.dart';
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
        BlocProvider(create: (context) => getIt.get<ArchiveCubit>()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        scaffoldMessengerKey: rootScaffoldMessengerState,
        theme: theme,
      ),
    );
  }
}
