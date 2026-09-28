import 'package:bloc/bloc.dart';
import 'package:courtclick/features/search/domain/entity/search_entity.dart';
import 'package:courtclick/features/search/domain/usecase/get_search_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetSearchUsecase getSearchUsecase;
  SearchCubit({required this.getSearchUsecase}) : super(SearchState.initial());

  String _latestQuery = '';

  /// [refresh] keeps the current results on screen (pull-to-refresh)
  /// instead of switching to the loading skeleton.
  Future<void> search({required String query, bool refresh = false}) async {
    _latestQuery = query;
    try {
      if (!refresh) emit(SearchState.loading());
      var res = await getSearchUsecase(query);
      // Ignore responses for an older query that finished late.
      if (isClosed || query != _latestQuery) return;
      res.fold(
        (l) => emit(SearchState.error(error: l.error)),
        (r) => emit(SearchState.loaded(data: r.results)),
      );
    } catch (e) {
      if (!isClosed) emit(SearchState.error(error: e.toString()));
    }
  }

  /// Re-runs the current query without showing the loading skeleton.
  Future<void> refresh() async {
    if (_latestQuery.isEmpty) return;
    await search(query: _latestQuery, refresh: true);
  }

  void clear() {
    _latestQuery = '';
    emit(SearchState.initial());
  }
}
