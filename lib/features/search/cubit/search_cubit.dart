import 'package:bloc/bloc.dart';
import 'package:courtclick/features/search/domain/entity/search_entity.dart';
import 'package:courtclick/features/search/domain/usecase/get_search_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetSearchUsecase getSearchUsecase;
  SearchCubit({required this.getSearchUsecase}) : super(SearchState.initial());

  void search({required String query}) async {
    try {
      var res = await getSearchUsecase(query);
      res.fold(
        (l) => emit(SearchState.error(error: l.error)),
        (r) => emit(SearchState.loaded(data: r.results)),
      );
    } catch (e) {
      emit(SearchState.error(error: e.toString()));
    }
  }
}
