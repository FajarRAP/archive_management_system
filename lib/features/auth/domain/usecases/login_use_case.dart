import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repositories.dart';

class LoginUseCase
    implements AsyncUseCaseWithParams<UserEntity, LoginUseCaseParams> {
  final AuthRepositories authRepositories;

  const LoginUseCase({required this.authRepositories});

  @override
  Future<Either<Failure, UserEntity>> call(LoginUseCaseParams params) {
    return authRepositories.login(params.email, params.password);
  }
}

class LoginUseCaseParams {
  final String email;
  final String password;

  const LoginUseCaseParams({required this.email, required this.password});
}
