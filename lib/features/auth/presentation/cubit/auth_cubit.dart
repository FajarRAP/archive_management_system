import 'package:archive_management_system/features/auth/domain/entities/profile_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getUserUseCase,
  }) : super(AuthInitial());

  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getUserUseCase;

  late UserEntity? user;
  late ProfileEntity userProfile;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final params = LoginUseCaseParams(email: email, password: password);

    final result = await loginUseCase(params);

    result.fold(
      (l) => emit(LoginError(l.message)),
      (r) => emit(LoginLoaded()),
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await logoutUseCase();

    result.fold(
      (l) => emit(LogoutError(l.message)),
      (r) => emit(LogoutLoaded(r)),
    );
  }

  Future<void> getCurrentUser() async {
    emit(ProfileLoading());

    final result = await getUserUseCase('${user?.id}');

    result.fold(
      (l) => emit(ProfileError(l.message)),
      (r) {
        userProfile = r;
        emit(ProfileLoaded(r));
      },
    );
  }
}
