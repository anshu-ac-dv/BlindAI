import 'package:blind_ai/BlinAI/domain/repositories/auth_repository.dart';
import 'package:blind_ai/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
