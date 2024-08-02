import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  CoffeeBloc({
    required CoffeeRepository repository,
  })  : _repository = repository,
        super(const CoffeeState()) {
    on<CoffeeRequested>(_onRequested);
  }

  final CoffeeRepository _repository;

  Future<void> _onRequested(
    CoffeeRequested event,
    Emitter<CoffeeState> emit,
  ) async {
    emit(state.copyWith(status: CoffeeStatus.loading));
    final result = await _repository.getRandomCoffee();
    result.when(
      ok: (image) {
        emit(
          state.copyWith(
            status: CoffeeStatus.success,
            currentUrl: image.$1,
            currentCoffee: image.$2,
          ),
        );
      },
      err: (failure) => emit(
        state.copyWith(
          status: switch (failure) {
            ConnectionFailure() => CoffeeStatus.noConnection,
            _ => CoffeeStatus.error,
          },
        ),
      ),
    );
  }
}
