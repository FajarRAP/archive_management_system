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
    final authCubit = context.read<AuthCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AuthCubit, AuthState>(
      bloc: authCubit..getCurrentUser(),
      buildWhen: (previous, current) => current is ProfileState,
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: const CircularProgressIndicator());
        }

        if (state is ProfileLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Profil',
                style: TextStyle(color: Colors.white),
              ),
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
                          color: colorScheme.primary,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        state.user.jobTitle,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.badge,
                                color: colorScheme.primary,
                              ),
                              title: Text(
                                'Nama',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(state.user.name),
                            ),
                            const Divider(),
                            ListTile(
                              leading: Icon(
                                Icons.credit_card,
                                color: colorScheme.primary,
                              ),
                              title: Text(
                                'NIP',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(state.user.employeeId),
                            ),
                            const Divider(),
                            ListTile(
                              leading: Icon(
                                Icons.work,
                                color: colorScheme.primary,
                              ),
                              title: Text(
                                'Jabatan',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(state.user.jobTitle),
                            ),
                            const Divider(),
                            const SizedBox(height: 24),
                            Align(
                              alignment: Alignment.center,
                              child: BlocConsumer<AuthCubit, AuthState>(
                                buildWhen: (previous, current) =>
                                    current is LogoutState,
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
                                    return ElevatedButton(
                                      onPressed: null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        elevation: 5,
                                        fixedSize: const Size.fromWidth(150),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      ),
                                    );
                                  }

                                  return ElevatedButton.icon(
                                    onPressed: authCubit.logout,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      elevation: 5,
                                      fixedSize: const Size.fromWidth(150),
                                      foregroundColor: colorScheme.onPrimary,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    icon: const Icon(Icons.logout),
                                    label: const Text(
                                      'Log Out',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
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

        return const SizedBox();
      },
    );
  }
}
