import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/core/usecase/usecase.dart';
import 'package:courtclick/features/search/domain/entity/search_entity.dart';
import 'package:courtclick/features/search/domain/repository/search_repository.dart';
import 'package:dartz/dartz.dart';

class GetSearchUsecase extends Usecase<SearchEntity, String> {
  final SearchRepository repository;

  new({required this.repository});
  @override
  Future<Either<Failure, SearchEntity>> call(String? param) async {
    return await repository.search(query: param!);
  }
}
