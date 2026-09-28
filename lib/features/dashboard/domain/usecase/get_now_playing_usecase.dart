import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/core/usecase/usecase.dart';
import 'package:courtclick/features/dashboard/domain/entity/now_playing_entity.dart';
import 'package:courtclick/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

class GetNowPlayingUsecase extends Usecase<NowPlayingEntity, void> {
  final DashboardRepository dashboardRepository;

  new({required this.dashboardRepository});
  @override
  Future<Either<Failure, NowPlayingEntity>> call(void param) async {
    return await dashboardRepository.nowPlaying();
  }
}
