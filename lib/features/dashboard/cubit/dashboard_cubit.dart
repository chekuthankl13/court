
import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/features/dashboard/domain/entity/all_week_entity.dart';
import 'package:courtclick/features/dashboard/domain/entity/now_playing_entity.dart';
import 'package:courtclick/features/dashboard/domain/entity/popular_entity.dart';
import 'package:courtclick/features/dashboard/domain/entity/top_rated_entity.dart';
import 'package:courtclick/features/dashboard/domain/usecase/get_all_week_usecase.dart';
import 'package:courtclick/features/dashboard/domain/usecase/get_now_playing_usecase.dart';
import 'package:courtclick/features/dashboard/domain/usecase/get_popular_usecase.dart';
import 'package:courtclick/features/dashboard/domain/usecase/get_top_rated_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetAllWeekUsecase getAllWeekUsecase;
  final GetNowPlayingUsecase getNowPlayingUsecase;
  final GetPopularUsecase getPopularUsecase;
  final GetTopRatedUsecase getTopRatedUsecase;
  DashboardCubit({
    required this.getAllWeekUsecase,
    required this.getNowPlayingUsecase,
    required this.getPopularUsecase,
    required this.getTopRatedUsecase,
  }) : super(DashboardState.initial());

  void loadHome() async {
    try {


 final results = await (
        getAllWeekUsecase(null),
        getNowPlayingUsecase(null),
        getPopularUsecase(null),
        getTopRatedUsecase(null),
      ).wait;

      final week = _getData(results.$1);
      final nowPlaying = _getData(results.$2);
      final popular = _getData(results.$3);
      final topRated = _getData(results.$4);

      if (isClosed) return;
emit(
        DashboardState.loaded(
          week: week,
          nowPlaying: nowPlaying,
          popular: popular,
          topRated: topRated,
        ),
      );

    } on _DashboardLoadException catch (e) {
      if (!isClosed) {
        emit(DashboardState.error(error: e.message));
      }
    } catch (e) {
      emit(DashboardState.error(error: e.toString()));
    }
  }


}


//// error setup

T _getData<T>(Either<Failure, T> result) {
  return result.fold(
    (failure) => throw _DashboardLoadException(failure.error),
    (data) => data,
  );
}

class _DashboardLoadException implements Exception {
  const _DashboardLoadException(this.message);

  final String message;
}

