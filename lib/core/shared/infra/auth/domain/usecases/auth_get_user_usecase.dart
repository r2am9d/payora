import 'package:payora/core/base/index.dart';
import 'package:payora/core/shared/infra/auth/index.dart';

class AuthGetUserUsecase implements Usecase<User, NoParams> {
  AuthGetUserUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<User> execute(NoParams params) async {
    return authRepository.getUser();
  }
}
