import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/features/coming/domain/entity/coming_soon_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ComingSoonRepository {
  Future<Either<Failure, ComingSoonEntity>> comingSoon();
}
