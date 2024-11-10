import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../repositories/auth_repositories.dart';

class LogoutUseCase implements AsyncUseCaseNoParams<String> {
  const LogoutUseCase({required this.authRepositories});

  final AuthRepositories authRepositories;

  @override
  Future<Either<Failure, String>> call() async {
    return await authRepositories.logout();
  }
}
