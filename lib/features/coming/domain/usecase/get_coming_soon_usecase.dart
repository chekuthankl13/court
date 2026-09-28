import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/core/usecase/usecase.dart';
import 'package:courtclick/features/coming/domain/entity/coming_soon_entity.dart';
import 'package:courtclick/features/coming/domain/repository/coming_soon_repository.dart';
import 'package:dartz/dartz.dart';

class GetComingSoonUsecase extends Usecase<ComingSoonEntity, void> {
  final ComingSoonRepository repository;

  new({required this.repository});
  @override
  Future<Either<Failure, ComingSoonEntity>> call(void param) async {
    return await repository.comingSoon();
  }
}
