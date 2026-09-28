part of 'coming_cubit.dart';

@freezed
class ComingState with _$ComingState {
  const ComingState._();
  const factory ComingState.initial() = Initial;
  const factory ComingState.loading() = Loading;
  const factory ComingState.error({required String error}) = Error;
  const factory ComingState.loaded({required ComingSoonEntity data}) = Loaded;
}
