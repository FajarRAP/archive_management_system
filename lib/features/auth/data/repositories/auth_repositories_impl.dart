import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/profile_model.dart';
import '../models/user_model.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  AuthRepositoriesImpl({required this.authRemoteDataSource});

  final AuthRemoteDataSource authRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final response = await authRemoteDataSource.login(email, password);

      if (response.user != null) {
        return Right(UserModel.fromUser(response.user!));
      }

      return Left(Failure());
    } catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      await authRemoteDataSource.logout();

      return Right('Berhasil Logout');
    } catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getCurrentUser(String userId) async {
    try {
      final datas = await authRemoteDataSource.getCurrentUser(userId);

      return Right(ProfileModel.fromJson(datas.first));
    } catch (e) {
      return Left(Failure(message: '$e'));
    }
  }
}
