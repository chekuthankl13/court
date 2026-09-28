import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/core/usecase/usecase.dart';
import 'package:courtclick/features/dashboard/domain/entity/all_week_entity.dart';
import 'package:courtclick/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllWeekUsecase extends Usecase<AllWeekEntity, void> {
  final DashboardRepository dashboardRepository;

  new({required this.dashboardRepository});
  @override
  Future<Either<Failure, AllWeekEntity>> call(void param) async {
    return await dashboardRepository.allWeek();
  }
}
