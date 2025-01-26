import 'package:flutter_application_2/bloc/event.dart';
import 'package:flutter_application_2/bloc/increment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<counterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0)) {
    on<CounterIncrementEvent>(
        (event, emit) => emit(CounterState(count: state.count + 1)));
    on<CounterDecrementEvent>(
        (event, emit) => emit(CounterState(count: state.count - 1)));
  }
}
