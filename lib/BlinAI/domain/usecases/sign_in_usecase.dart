import 'package:blind_ai/BlinAI/domain/repositories/auth_repository.dart';
import 'package:blind_ai/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signIn(email: email, password: password);
  }
}
