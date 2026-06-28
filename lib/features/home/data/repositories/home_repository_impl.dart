import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, String>> processCommand(String command) async {
    // For now, we simulate a process.
    await Future.delayed(const Duration(milliseconds: 500));
    return Right('Processed: $command');
  }
}
