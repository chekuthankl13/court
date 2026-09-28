import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/core/usecase/usecase.dart';
import 'package:courtclick/features/dashboard/domain/entity/popular_entity.dart';
import 'package:courtclick/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

class GetPopularUsecase extends Usecase<PopularEntity, void> {
  final DashboardRepository dashboardRepository;

  new({required this.dashboardRepository});
  @override
  Future<Either<Failure, PopularEntity>> call(void param) async {
    return await dashboardRepository.popular();
  }
}
