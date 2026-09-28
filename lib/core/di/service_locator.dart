import 'package:courtclick/core/service/dio_service.dart';
import 'package:courtclick/features/coming/cubit/coming_cubit.dart';
import 'package:courtclick/features/coming/data/data_source/coming_soon_remote_data_source.dart';
import 'package:courtclick/features/coming/data/repository/coming_soon_repository_impl.dart';
import 'package:courtclick/features/coming/domain/repository/coming_soon_repository.dart';
import 'package:courtclick/features/coming/domain/usecase/get_coming_soon_usecase.dart';
import 'package:courtclick/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:courtclick/features/dashboard/data/data_source/dash_board_remote_datasource.dart';
import 'package:courtclick/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:courtclick/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:courtclick/features/dashboard/domain/usecase/get_all_week_usecase.dart';
import 'package:courtclick/features/dashboard/domain/usecase/get_now_playing_usecase.dart';
import 'package:courtclick/features/dashboard/domain/usecase/get_popular_usecase.dart';
import 'package:courtclick/features/dashboard/domain/usecase/get_top_rated_usecase.dart';
import 'package:courtclick/features/search/cubit/search_cubit.dart';
import 'package:courtclick/features/search/data/data_source/search_remote_data_source.dart';
import 'package:courtclick/features/search/data/repository/search_repository_impl.dart';
import 'package:courtclick/features/search/domain/repository/search_repository.dart';
import 'package:courtclick/features/search/domain/usecase/get_search_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initDi() async {
  ///dio setup

  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
     
        baseUrl: dotenv.get('API_BASE_URL', fallback: ''),
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
        headers: {'Accept': 'application/json'},
      ),
    ),
  );

  sl.registerLazySingleton<DioService>(
    () =>
        DioService(dio: sl<Dio>(), getToken: () => dotenv.env['ACCESS_TOKEN']),
    dispose: (service) => service.dispose(),
  );

  //\/\/\/\/\/\/\//\/\/\/\/\ dashboard /\/\/\/\/\/\/\/\/\/\/\/\/\

  sl.registerLazySingleton<DashBoardRemoteDatasource>(
    () => DashBoardRemoteDatasourceImpl(dioService: sl<DioService>()),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDatasource: sl<DashBoardRemoteDatasource>(),
    ),
  );

  ///usecase
  sl.registerLazySingleton<GetTopRatedUsecase>(
    () => GetTopRatedUsecase(dashboardRepository: sl()),
  );

  sl.registerLazySingleton<GetAllWeekUsecase>(
    () => GetAllWeekUsecase(dashboardRepository: sl()),
  );

  sl.registerLazySingleton<GetNowPlayingUsecase>(
    () => GetNowPlayingUsecase(dashboardRepository: sl()),
  );

  sl.registerLazySingleton<GetPopularUsecase>(
    () => GetPopularUsecase(dashboardRepository: sl()),
  );

  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(
      getAllWeekUsecase: sl(),
      getNowPlayingUsecase: sl(),
      getPopularUsecase: sl(),
      getTopRatedUsecase: sl(),
    ),
  );

  //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/  search /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(dioService: sl<DioService>()),
  );

  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(remoteDataSource: sl<SearchRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetSearchUsecase>(
    () => GetSearchUsecase(repository: sl()),
  );

  sl.registerFactory<SearchCubit>(() => SearchCubit(getSearchUsecase: sl()));

  //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ coming soon /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

  sl.registerLazySingleton<ComingSoonRemoteDataSource>(
    () => ComingSoonRemoteDataSourceImpl(dioService: sl<DioService>()),
  );

  sl.registerLazySingleton<ComingSoonRepository>(
    () => ComingSoonRepositoryImpl(
      remoteDataSource: sl<ComingSoonRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetComingSoonUsecase>(
    () => GetComingSoonUsecase(repository: sl()),
  );

  sl.registerFactory<ComingCubit>(
    () => ComingCubit(getComingSoonUsecase: sl()),
  );
}
