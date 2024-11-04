import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepositories {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, String>> logout();
}