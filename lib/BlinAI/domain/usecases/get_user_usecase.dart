import 'package:blind_ai/BlinAI/domain/entities/user_entity.dart';
import 'package:blind_ai/BlinAI/domain/repositories/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository repository;

  GetUserUseCase(this.repository);

  Stream<UserEntity?> call() {
    return repository.user;
  }
}
