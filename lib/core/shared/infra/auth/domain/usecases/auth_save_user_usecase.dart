import 'package:payora/core/base/index.dart';
import 'package:payora/core/errors/index.dart';
import 'package:payora/core/shared/infra/auth/index.dart';

class AuthSaveUserUsecase implements Usecase<void, User> {
  AuthSaveUserUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<void> execute(User user) async {
    if (user.id <= 0) {
      throw ValidationException.greaterThanZero('id');
    }

    if (user.username.isEmpty) {
      throw ValidationException.emptyField('username');
    }

    if (user.password.isEmpty) {
      throw ValidationException.emptyField('password');
    }

    if (user.details.firstname.isEmpty) {
      throw ValidationException.emptyField('firstname');
    }

    if (user.details.lastname.isEmpty) {
      throw ValidationException.emptyField('lastname');
    }

    if (user.details.balance < 0) {
      throw ValidationException.nonNegative('balance');
    }

    await authRepository.saveUser(user);
  }
}
