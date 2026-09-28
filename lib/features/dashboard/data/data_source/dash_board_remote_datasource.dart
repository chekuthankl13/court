import 'package:courtclick/core/config/config.dart';
import 'package:courtclick/core/error/exceptions.dart';
import 'package:courtclick/core/service/dio_service.dart';
import 'package:courtclick/features/dashboard/data/models/all_week_entity_model.dart';
import 'package:courtclick/features/dashboard/data/models/now_playing_entity_model.dart';
import 'package:courtclick/features/dashboard/data/models/popular_entity_model.dart';
import 'package:courtclick/features/dashboard/data/models/top_rated_entity_model.dart';

abstract interface class DashBoardRemoteDatasource {
  Future<AllWeekEntityModel> getAllWeek();
  Future<NowPlayingEntityModel> getNowPlaying();
  Future<PopularEntityModel> getPopular();
  Future<TopRatedEntityModel> getTopRated();
}

class DashBoardRemoteDatasourceImpl implements DashBoardRemoteDatasource {
  final DioService _dioService;

  new({required this._dioService});

  @override
  Future<AllWeekEntityModel> getAllWeek() async {
    final data = await _dioService.get(url: Config.allWeek);
    if (data is! Map<String, dynamic>) {
      throw ServerException(error: 'Invalid top-rated response.');
    }

    return AllWeekEntityModel.fromJson(data);
  }

  @override
  Future<NowPlayingEntityModel> getNowPlaying() async {
    final data = await _dioService.get(url: Config.nowPlaying);
    if (data is! Map<String, dynamic>) {
      throw ServerException(error: 'Invalid now playing response.');
    }

    return NowPlayingEntityModel.fromJson(data);
  }

  @override
  Future<PopularEntityModel> getPopular() async {
    final data = await _dioService.get(url: Config.popular);
    if (data is! Map<String, dynamic>) {
      throw ServerException(error: 'Invalid popular response.');
    }

    return PopularEntityModel.fromJson(data);
  }

  @override
  Future<TopRatedEntityModel> getTopRated() async {
    final data = await _dioService.get(url: Config.topRated);
    if (data is! Map<String, dynamic>) {
      throw ServerException(error: 'Invalid top rated response.');
    }

    return TopRatedEntityModel.fromJson(data);
  }
}
