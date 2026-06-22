part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

final class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

final class SignOutRequested extends AuthEvent {}

final class AuthStatusChanged extends AuthEvent {
  final UserEntity? user;
  const AuthStatusChanged(this.user);

  @override
  List<Object?> get props => [user];
}
