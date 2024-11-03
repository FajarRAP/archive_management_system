import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

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
}
