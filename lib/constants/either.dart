import 'package:dartz/dartz.dart';

import 'failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureUnit = FutureEither<Unit>;
