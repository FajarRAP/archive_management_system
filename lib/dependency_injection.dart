import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/archive/data/datasources/archive_remote_data_source.dart';
import 'features/archive/data/repositories/archive_repositories_impl.dart';
import 'features/archive/domain/repositories/archive_repositories.dart';
import 'features/archive/domain/usecases/borrow_archive_use_case.dart';
import 'features/archive/domain/usecases/delete_archive_use_case.dart';
import 'features/archive/domain/usecases/download_archive_report_use_case.dart';
import 'features/archive/domain/usecases/get_archive_loans_by_user_use_case.dart';
import 'features/archive/domain/usecases/get_archive_loans_use_case.dart';
import 'features/archive/domain/usecases/get_archive_statistics_use_case.dart';
import 'features/archive/domain/usecases/get_archives_use_case.dart';
import 'features/archive/domain/usecases/get_not_returned_archive_loans_use_case.dart';
import 'features/archive/domain/usecases/insert_archive_use_case.dart';
import 'features/archive/domain/usecases/return_borrowed_archive_use_case.dart';
import 'features/archive/domain/usecases/update_archive_use_case.dart';
import 'features/archive/presentation/cubit/archive_cubit.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'features/auth/domain/repositories/auth_repositories.dart';
import 'features/auth/domain/usecases/get_current_user_use_case.dart';
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
        getUserUseCase: GetCurrentUserUseCase(authRepositories: getIt.get()),
      ),
    );

  getIt
    ..registerLazySingleton<ArchiveRemoteDataSource>(
        () => ArchiveRemoteDataSourceImpl(supabase: getIt.get()))
    ..registerLazySingleton<ArchiveRepositories>(
        () => ArchiveRepositoriesImpl(archiveRemoteDataSource: getIt.get()))
    ..registerLazySingleton<ArchiveCubit>(
      () => ArchiveCubit(
          getArchivesUseCase:
              GetArchivesUseCase(archiveRepositories: getIt.get()),
          getArchiveLoansUseCase:
              GetArchiveLoansUseCase(archiveRepositories: getIt.get()),
          getArchiveLoansByUserUseCase:
              GetArchiveLoansByUserUseCase(archiveRepositories: getIt.get()),
          getArchiveStatisticsUseCase:
              GetArchiveStatisticsUseCase(archiveRepositories: getIt.get()),
          insertArchiveUseCase:
              InsertArchiveUseCase(archiveRepositories: getIt.get()),
          updateArchiveUseCase:
              UpdateArchiveUseCase(archiveRepositories: getIt.get()),
          deleteArchiveUseCase:
              DeleteArchiveUseCase(archiveRepositories: getIt.get()),
          borrowArchiveUseCase:
              BorrowArchiveUseCase(archiveRepositories: getIt.get()),
          returnBorrowedArchiveUseCase:
              ReturnBorrowedArchiveUseCase(archiveRepositories: getIt.get()),
          downloadArchiveReportUseCase:
              DownloadArchiveReportUseCase(archiveRepositories: getIt.get()),
          getNotReturnedArchiveLoansUseCase: GetNotReturnedArchiveLoansUseCase(
              archiveRepositories: getIt.get())),
    );
}
