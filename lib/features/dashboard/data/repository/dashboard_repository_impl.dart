import 'package:courtclick/core/error/exceptions.dart';
import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/core/utils/utils.dart';
import 'package:courtclick/features/dashboard/domain/entity/all_week_entity.dart';
import 'package:courtclick/features/dashboard/domain/entity/now_playing_entity.dart';
import 'package:courtclick/features/dashboard/domain/entity/popular_entity.dart';
import 'package:courtclick/features/dashboard/domain/entity/top_rated_entity.dart';
import 'package:courtclick/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:courtclick/features/dashboard/data/data_source/dash_board_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DashBoardRemoteDatasource _remoteDatasource;

  new({required this._remoteDatasource});

  @override
  Future<Either<Failure, AllWeekEntity>> allWeek()async {
     try {
      final result = await _remoteDatasource.getAllWeek();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Left(NetworkFailure(error: 'Check your internet connection.'));

        case DioExceptionType.badResponse:
          final status = e.response?.statusCode;
          final message = errorMessage(e.response?.data);

          if (status == 401 || status == 403) {
            return Left(
              AuthenticationFailure(error: message ?? 'Authentication failed.'),
            );
          }

          if (status == 404) {
            return Left(
              NotFoundFailure(
                error: message ?? 'Requested data was not found.',
              ),
            );
          }

          return Left(
            ServerFailure(error: message ?? 'Server error. Please try again.'),
          );

        default:
          return Left(ExceptionFailure(error: e.message ?? 'Request failed.'));
      }
    } catch (e) {
      return Left(ExceptionFailure(error: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, NowPlayingEntity>> nowPlaying()async {
     try {
      final result = await _remoteDatasource.getNowPlaying();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Left(NetworkFailure(error: 'Check your internet connection.'));

        case DioExceptionType.badResponse:
          final status = e.response?.statusCode;
          final message = errorMessage(e.response?.data);

          if (status == 401 || status == 403) {
            return Left(
              AuthenticationFailure(error: message ?? 'Authentication failed.'),
            );
          }

          if (status == 404) {
            return Left(
              NotFoundFailure(
                error: message ?? 'Requested data was not found.',
              ),
            );
          }

          return Left(
            ServerFailure(error: message ?? 'Server error. Please try again.'),
          );

        default:
          return Left(ExceptionFailure(error: e.message ?? 'Request failed.'));
      }
    } catch (e) {
      return Left(ExceptionFailure(error: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, PopularEntity>> popular() async{
     try {
      final result = await _remoteDatasource.getPopular();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Left(NetworkFailure(error: 'Check your internet connection.'));

        case DioExceptionType.badResponse:
          final status = e.response?.statusCode;
          final message = errorMessage(e.response?.data);

          if (status == 401 || status == 403) {
            return Left(
              AuthenticationFailure(error: message ?? 'Authentication failed.'),
            );
          }

          if (status == 404) {
            return Left(
              NotFoundFailure(
                error: message ?? 'Requested data was not found.',
              ),
            );
          }

          return Left(
            ServerFailure(error: message ?? 'Server error. Please try again.'),
          );

        default:
          return Left(ExceptionFailure(error: e.message ?? 'Request failed.'));
      }
    } catch (e) {
      return Left(ExceptionFailure(error: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, TopRatedEntity>> topRated() async {
    try {
      final result = await _remoteDatasource.getTopRated();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Left(NetworkFailure(error: 'Check your internet connection.'));

        case DioExceptionType.badResponse:
          final status = e.response?.statusCode;
          final message = errorMessage(e.response?.data);

          if (status == 401 || status == 403) {
            return Left(
              AuthenticationFailure(error: message ?? 'Authentication failed.'),
            );
          }

          if (status == 404) {
            return Left(
              NotFoundFailure(
                error: message ?? 'Requested data was not found.',
              ),
            );
          }

          return Left(
            ServerFailure(error: message ?? 'Server error. Please try again.'),
          );

        default:
          return Left(ExceptionFailure(error: e.message ?? 'Request failed.'));
      }
    } catch (e) {
      return Left(ExceptionFailure(error: 'Unexpected error: $e'));
    }
  }
}
