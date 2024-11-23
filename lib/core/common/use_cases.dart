import 'failure.dart';
import 'package:dartz/dartz.dart';

abstract interface class AsyncUseCaseNoParams<ReturnType> {
  Future<Either<Failure, ReturnType>> call();
}

abstract interface class AsyncUseCaseWithParams<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

abstract interface class UseCaseNoParams<ReturnType> {
  ReturnType call();
}

abstract interface class UseCaseWithParams<ReturnType, Params> {
  ReturnType call(Params params);
}
