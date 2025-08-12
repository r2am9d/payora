import 'package:payora/core/base/index.dart';
import 'package:payora/core/shared/infra/auth/index.dart';

class AuthLogoutUsecase implements Usecase<void, NoParams> {
  AuthLogoutUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<void> execute(NoParams params) async {
    await authRepository.logout();
  }
}
