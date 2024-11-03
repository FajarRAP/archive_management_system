import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/common/snack_bar.dart';
import '../cubit/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: colorScheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Pengelola Informasi',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.badge, color: colorScheme.primary),
                        title: Text(
                          'Nama',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('John Doe'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.credit_card,
                          color: colorScheme.primary,
                        ),
                        title: Text(
                          'NIP',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('2100018165'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(Icons.work, color: colorScheme.primary),
                        title: Text(
                          'Jabatan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Pengelola Informasi'),
                      ),
                      const Divider(),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          onPressed: () async => await authCubit.logout(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: colorScheme.onPrimary,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          icon: Icon(Icons.logout, color: Colors.white),
                          label: BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is LogoutLoaded) {
                                showSnackBar(message: state.message);
                                context.go(loginRoute);
                              }

                              if (state is LogoutError) {
                                showSnackBar(message: state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is LogoutLoading) {
                                return const CircularProgressIndicator();
                              }
                              return Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
