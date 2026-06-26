import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String email, String password, String name);
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Stream<UserModel?> get user;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (response.user != null) {
      return UserModel.fromFirebase(response.user!);
    } else {
      throw Exception('Login failed');
    }
  }

  @override
  Future<UserModel> signUp(String email, String password, String name) async {
    final response = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (response.user != null) {
      await response.user!.updateDisplayName(name);
      return UserModel.fromFirebase(response.user!);
    } else {
      throw Exception('Sign up failed');
    }
  }

  @override
  Future<void> logout() => firebaseAuth.signOut();

  @override
  Future<void> forgotPassword(String email) =>
      firebaseAuth.sendPasswordResetEmail(email: email);

  @override
  Stream<UserModel?> get user => firebaseAuth.authStateChanges().map(
        (firebaseUser) =>
            firebaseUser != null ? UserModel.fromFirebase(firebaseUser) : null,
      );
}
