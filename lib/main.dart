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
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                )),
            filled: true,
            fillColor: Colors.grey.shade50,
            hintStyle: TextStyle(color: Colors.grey.shade400),
          ),
          dropdownMenuTheme: DropdownMenuThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              // ),
              filled: true,
              fillColor: Colors.grey.shade50,
              hintStyle: TextStyle(color: Colors.grey.shade400),
            ),
          ),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
