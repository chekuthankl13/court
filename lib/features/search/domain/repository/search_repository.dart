import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/features/search/domain/entity/search_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchEntity>> search({required String query});
}
