part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const DashboardState._();
  const factory DashboardState.initial() = Initial;
  const factory DashboardState.loading() = Loading;
  const factory DashboardState.error({required String error}) = Error;
  const factory DashboardState.loaded({
    required AllWeekEntity week,
    required NowPlayingEntity nowPlaying,
    required PopularEntity popular,
    required TopRatedEntity topRated,
  }) = Loaded;
}
