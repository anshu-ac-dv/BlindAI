import 'package:blind_ai/BlinAI/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:blind_ai/core/error/failures.dart';

abstract class AuthRepository {
  Stream<UserEntity?> get user;
  Future<Either<Failure, void>> signUp({required String email, required String password});
  Future<Either<Failure, void>> signIn({required String email, required String password});
  Future<Either<Failure, void>> signOut();
}
