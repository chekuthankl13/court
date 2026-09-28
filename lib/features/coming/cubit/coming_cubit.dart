import 'package:bloc/bloc.dart';
import 'package:courtclick/features/coming/domain/entity/coming_soon_entity.dart';
import 'package:courtclick/features/coming/domain/usecase/get_coming_soon_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coming_state.dart';
part 'coming_cubit.freezed.dart';

class ComingCubit extends Cubit<ComingState> {
  final GetComingSoonUsecase getComingSoonUsecase;
  ComingCubit({required this.getComingSoonUsecase})
    : super(ComingState.initial());


  Future<void> loadComingSoon({bool refresh = false}) async {
    try {
      if (!refresh) emit(ComingState.loading());
      var res = await getComingSoonUsecase(null);
      if (isClosed) return;
      res.fold(
        (l) => emit(ComingState.error(error: l.error)),
        (r) => emit(ComingState.loaded(data: r)),
      );
    } catch (e) {
      emit(ComingState.error(error: e.toString()));
    }
  }
}
