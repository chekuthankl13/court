import 'package:courtclick/features/search/data/model/search_entity_model.dart';
import 'package:courtclick/core/service/dio_service.dart';
import 'package:courtclick/core/config/config.dart';
import 'package:courtclick/core/error/exceptions.dart';

abstract interface class SearchRemoteDataSource {
  Future<SearchEntityModel> search({required String query});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final DioService _dioService;

  new({required this._dioService});

  @override
  Future<SearchEntityModel> search({required String query}) async {
    final data = await _dioService.get(
      url: Config.search + Uri.encodeQueryComponent(query),
    );
    if (data is! Map<String, dynamic>) {
      throw ServerException(error: 'Invalid search response.');
    }

    return SearchEntityModel.fromJson(data);
  }
}
