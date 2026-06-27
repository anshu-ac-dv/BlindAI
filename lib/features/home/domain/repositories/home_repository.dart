import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, String>> processCommand(String command);
}
