import 'package:courtclick/core/config/config.dart';
import 'package:courtclick/core/error/exceptions.dart';
import 'package:courtclick/core/service/dio_service.dart';
import 'package:courtclick/features/coming/data/model/coming_soon_entity_model.dart';

abstract interface class ComingSoonRemoteDataSource {
  Future<ComingSoonEntityModel> comingSoon();
}


class ComingSoonRemoteDataSourceImpl implements ComingSoonRemoteDataSource {

  final DioService _dioService;

  new({required this._dioService});
  @override
  Future<ComingSoonEntityModel> comingSoon()async {
     final data = await _dioService.get(url: Config.coming);
    if (data is! Map<String, dynamic>) {
      throw ServerException(error: 'Invalid search response.');
    }

    return ComingSoonEntityModel.fromJson(data);
  }
  
}