import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/use_cases.dart';
import '../entities/profile_entity.dart';
import '../repositories/auth_repositories.dart';

class GetCurrentUserUseCase
    implements AsyncUseCaseWithParams<ProfileEntity, String> {
  final AuthRepositories authRepositories;

  const GetCurrentUserUseCase({required this.authRepositories});

  @override
  Future<Either<Failure, ProfileEntity>> call(String params) async {
    return await authRepositories.getCurrentUser(params);
  }
}
