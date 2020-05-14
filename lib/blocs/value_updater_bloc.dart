import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class ValueUpdaterBloc extends Bloc<ValueUpdaterEvent, ValueUpdaterState> {
  @override
  ValueUpdaterState get initialState => ValueUpdaterState.initial();

  @override
  Stream<ValueUpdaterState> mapEventToState(ValueUpdaterEvent event) async* {
    if (event is IncrementEvent) {
      // Yielding loading state
      yield state.copyWith(
          updatedState: ValueUpdatingState(ValueUpdationType.increment));

      // Mocking a network call
      await Future.delayed(Duration(seconds: 1));

      // Incrementing the current value
      final updatedValue = state.currentValue + 1;

      if (updatedValue <= 10) {
        // Yielding success state
        yield state.copyWith(
          updatedState: ValueUpdatedState(ValueUpdationType.increment),
          updatedValue: updatedValue,
        );
      } else {
        // Yielding failure state
        yield state.copyWith(
          updatedState: ValueUpdationFailedState(
              "Cannot increment value to more than 10",
              ValueUpdationType.increment),
        );
      }
    }

    if (event is DecrementEvent) {
      // Yielding loading state
      yield state.copyWith(
          updatedState: ValueUpdatingState(ValueUpdationType.decrement));

      // Mocking a network call
      await Future.delayed(Duration(seconds: 1));

      // Decrementing the current value
      final updatedValue = state.currentValue - 1;

      if (updatedValue >= 0) {
        // Yielding success state
        yield state.copyWith(
          updatedState: ValueUpdatedState(ValueUpdationType.decrement),
          updatedValue: updatedValue,
        );
      } else {
        // Yielding failure state
        yield state.copyWith(
          updatedState: ValueUpdationFailedState(
              "Cannot decrement to a negative value",
              ValueUpdationType.decrement),
        );
      }
    }
  }
}
