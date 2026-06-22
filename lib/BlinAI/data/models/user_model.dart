import 'package:blind_ai/BlinAI/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class UserModel extends UserEntity {
  const UserModel({required super.id, super.email});

  factory UserModel.fromFirebaseUser(firebase.User user) {
    return UserModel(
      id: user.uid,
      email: user.email,
    );
  }
}
