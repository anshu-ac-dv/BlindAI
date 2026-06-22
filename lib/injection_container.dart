import 'package:blind_ai/BlinAI/data/datasources/auth_remote_data_source.dart';
import 'package:blind_ai/BlinAI/data/repositories/auth_repository_impl.dart';
import 'package:blind_ai/BlinAI/domain/repositories/auth_repository.dart';
import 'package:blind_ai/BlinAI/domain/usecases/get_user_usecase.dart';
import 'package:blind_ai/BlinAI/domain/usecases/sign_in_usecase.dart';
import 'package:blind_ai/BlinAI/domain/usecases/sign_out_usecase.dart';
import 'package:blind_ai/BlinAI/domain/usecases/sign_up_usecase.dart';
import 'package:blind_ai/BlinAI/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
      getUserUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
