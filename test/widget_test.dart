import 'package:flutter_test/flutter_test.dart';
import 'package:blind_ai/main.dart';
import 'package:blind_ai/injection_container.dart' as di;
import 'package:blind_ai/core/theme/bloc/theme_bloc.dart';
import 'package:blind_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blind_ai/features/auth/domain/repositories/auth_repository.dart';
import 'package:blind_ai/features/auth/domain/entities/user_entity.dart';
import 'package:blind_ai/core/error/failures.dart';
import 'package:blind_ai/features/auth/domain/usecases/login_usecase.dart';
import 'package:blind_ai/features/auth/domain/usecases/signup_usecase.dart';
import 'package:blind_ai/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:dartz/dartz.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Stream<UserEntity?> get user => Stream.value(null);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async =>
      const Left(AuthFailure('Mock error'));

  @override
  Future<Either<Failure, UserEntity>> signUp(String email, String password, String name) async =>
      const Left(AuthFailure('Mock error'));

  @override
  Future<Either<Failure, void>> logout() async => const Right(null);

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async => const Right(null);
}

void main() {
  setUp(() {
    di.sl.reset();
    di.sl.registerLazySingleton(() => ThemeBloc());
    final mockAuthRepo = MockAuthRepository();
    final loginUseCase = LoginUseCase(mockAuthRepo);
    final signupUseCase = SignupUseCase(mockAuthRepo);
    final forgotPasswordUseCase = ForgotPasswordUseCase(mockAuthRepo);
    di.sl.registerLazySingleton<AuthRepository>(() => mockAuthRepo);
    di.sl.registerLazySingleton(() => loginUseCase);
    di.sl.registerLazySingleton(() => signupUseCase);
    di.sl.registerLazySingleton(() => forgotPasswordUseCase);
    di.sl.registerFactory(
      () => AuthBloc(
        loginUseCase: loginUseCase,
        signupUseCase: signupUseCase,
        forgotPasswordUseCase: forgotPasswordUseCase,
        authRepository: mockAuthRepo,
      ),
    );
  });

  testWidgets('Blind AI smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that splash screen shows the app name.
    expect(find.text('BLINDAI'), findsOneWidget);

    // Advance past the 4s splash delay and 1s route transition
    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(seconds: 2));
  });
}
