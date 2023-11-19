import 'package:fpdart/fpdart.dart';
import 'failure.dart';

// typedef for handling return in provider
typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
