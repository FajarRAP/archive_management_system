import 'package:archive_management_system/core/common/failure.dart';
import 'package:archive_management_system/core/common/use_cases.dart';
import 'package:archive_management_system/features/auth/domain/repositories/auth_repositories.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase implements AsyncUseCaseNoParams<String> {
  const LogoutUseCase({required this.authRepositories});

  final AuthRepositories authRepositories;

  @override
  Future<Either<Failure, String>> call() async {
    return await authRepositories.logout();
  }
}
