import 'package:payora/core/base/index.dart';
import 'package:payora/core/errors/index.dart';
import 'package:payora/core/shared/infra/auth/index.dart';

class AuthLoginUsecase implements Usecase<User, LoginParams> {
  AuthLoginUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<User> execute(LoginParams params) async {
    if (params.username.isEmpty) {
      throw ValidationException.emptyField('username');
    }

    if (params.password.isEmpty) {
      throw ValidationException.emptyField('password');
    }

    return authRepository.login(params.username, params.password);
  }
}
