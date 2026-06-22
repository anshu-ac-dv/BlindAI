import 'package:blind_ai/BlinAI/domain/repositories/auth_repository.dart';
import 'package:blind_ai/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signUp(email: email, password: password);
  }
}
