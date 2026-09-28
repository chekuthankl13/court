
import 'package:courtclick/core/error/failure.dart';
import 'package:dartz/dartz.dart';



abstract class Usecase<T,Params> {
 Future<Either<Failure,T>> call(Params? param);
}

abstract class Usecase2<Type,Params> {
 Future<Type> call(Params param);
}

class NoParam  {
}