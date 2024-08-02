import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'saves_event.dart';
part 'saves_state.dart';

class SavesBloc extends HydratedBloc<SavesEvent, SavesState> {
  SavesBloc() : super(const SavesState()) {
    on<SavesToggled>(_onToggled);
  }

  void _onToggled(
    SavesToggled event,
    Emitter<SavesState> emit,
  ) {
    final url = event.url;
    final saves = {...state.saves};

    if (saves.containsKey(url)) {
      saves.remove(url);
      emit(state.copyWith(saves: saves));
    } else {
      emit(state.copyWith(saves: {...saves, url: event.image}));
    }
  }

  @override
  SavesState? fromJson(Map<String, dynamic> json) {
    final saves = json['saves'] as Map<String, dynamic>;

    return SavesState(saves: saves.cast<String, Uint8List>());
  }

  @override
  Map<String, dynamic>? toJson(SavesState state) {
    return {'saves': state.saves};
  }
}
