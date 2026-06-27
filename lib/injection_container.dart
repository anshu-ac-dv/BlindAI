import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/forgot_password_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/signup_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/domain/usecases/process_command_usecase.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/vision/presentation/bloc/vision_bloc.dart';
import 'core/theme/bloc/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton(() => ThemeBloc());

  //! Features - Authentication
  
  // Blocs - Factory: always creates a new instance
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      signupUseCase: sl(),
      forgotPasswordUseCase: sl(),
      authRepository: sl(),
    ),
  );

  // Use cases - LazySingleton: instance created only when needed
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));

  // Repository - Implementation linked to interface
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Data sources - Direct Firebase interaction
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  //! Features - Home
  sl.registerFactory(() => HomeBloc(processCommandUseCase: sl()));
  sl.registerLazySingleton(() => ProcessCommandUseCase(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());

  //! Features - Vision
  sl.registerFactory(() => VisionBloc());

  //! External
  final auth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => auth);
}
