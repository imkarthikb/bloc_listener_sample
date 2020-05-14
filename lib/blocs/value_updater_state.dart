import 'package:flutter/foundation.dart';

class ValueUpdaterState {
  final int currentValue;
  final ValueUpdaterSubState substate;

  ValueUpdaterState({@required this.currentValue, @required this.substate});

  factory ValueUpdaterState.initial() => ValueUpdaterState(
        currentValue: 0,
        substate: ValueUpdaterInitialState(),
      );

  ValueUpdaterState copyWith({
    int updatedValue,
    ValueUpdaterSubState updatedState,
  }) {
    return ValueUpdaterState(
      currentValue: updatedValue ?? this.currentValue,
      substate: updatedState ?? this.substate,
    );
  }
}

abstract class ValueUpdaterSubState {}

class ValueUpdaterInitialState extends ValueUpdaterSubState {}

class ValueUpdatingState extends ValueUpdaterSubState {
  final ValueUpdationType type;

  ValueUpdatingState(this.type);
}

class ValueUpdatedState extends ValueUpdaterSubState {
  final ValueUpdationType type;

  ValueUpdatedState(this.type);
}

class ValueUpdationFailedState extends ValueUpdaterSubState {
  final ValueUpdationType type;
  final String errorMessage;

  ValueUpdationFailedState(this.errorMessage, this.type);
}

enum ValueUpdationType { increment, decrement }
