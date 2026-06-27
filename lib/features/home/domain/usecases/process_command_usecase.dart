import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class ProcessCommandUseCase implements UseCase<String, String> {
  final HomeRepository repository;

  ProcessCommandUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String params) async {
    return await repository.processCommand(params);
  }
}
