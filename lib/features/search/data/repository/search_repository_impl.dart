import 'package:courtclick/core/error/exceptions.dart';
import 'package:courtclick/core/error/failure.dart';
import 'package:courtclick/core/utils/utils.dart';
import 'package:courtclick/features/search/data/data_source/search_remote_data_source.dart';
import 'package:courtclick/features/search/domain/entity/search_entity.dart';
import 'package:courtclick/features/search/domain/repository/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  new({required this._remoteDataSource});

  @override
  Future<Either<Failure, SearchEntity>> search({required String query}) async{
    try {
      final result = await _remoteDataSource.search(query: query);
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
