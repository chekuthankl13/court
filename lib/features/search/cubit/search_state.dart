part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const SearchState._();
  const factory SearchState.initial() = Initial;
  const factory SearchState.loading() = Loading;
  const factory SearchState.error({required String error}) = Error;
  const factory SearchState.loaded({required List<SearchResult> data}) = Loaded;

}
