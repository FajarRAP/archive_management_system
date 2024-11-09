import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../repositories/auth_repositories.dart';

class GetCurrentUserUseCase
    implements AsyncUseCaseWithParams<Map<String, dynamic>, String> {
  final AuthRepositories authRepositories;

  const GetCurrentUserUseCase({required this.authRepositories});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(String params) async {
    return await authRepositories.getCurrentUser(params);
  }
}
