import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'features/auth/domain/repositories/auth_repositories.dart';
import 'features/auth/domain/usecases/login_use_case.dart';
import 'features/auth/domain/usecases/logout_use_case.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(supabase: getIt.get()))
    ..registerLazySingleton<AuthRepositories>(
        () => AuthRepositoriesImpl(authRemoteDataSource: getIt.get()))
    ..registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        loginUseCase: LoginUseCase(authRepositories: getIt.get()),
        logoutUseCase: LogoutUseCase(authRepositories: getIt.get()),
      ),
    );
}
