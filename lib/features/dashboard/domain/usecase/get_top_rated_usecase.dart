import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/core/usecase/usecase.dart';
import 'package:courtclick/features/dashboard/domain/entity/top_rated_entity.dart';
import 'package:courtclick/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedUsecase extends Usecase<TopRatedEntity, void> {
  final DashboardRepository dashboardRepository;

  new({required this.dashboardRepository});
  @override
  Future<Either<Failure, TopRatedEntity>> call(void param) async {
    return await dashboardRepository.topRated();
  }
}
