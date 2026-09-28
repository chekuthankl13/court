import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/features/dashboard/domain/entity/all_week_entity.dart';
import 'package:courtclick/features/dashboard/domain/entity/now_playing_entity.dart';
import 'package:courtclick/features/dashboard/domain/entity/popular_entity.dart';
import 'package:courtclick/features/dashboard/domain/entity/top_rated_entity.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardRepository {
  Future<Either<Failure, AllWeekEntity>> allWeek();
  Future<Either<Failure, NowPlayingEntity>> nowPlaying();
  Future<Either<Failure, PopularEntity>> popular();
  Future<Either<Failure, TopRatedEntity>> topRated();
}
