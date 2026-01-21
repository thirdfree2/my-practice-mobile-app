import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<CounterIncremented>((event, emit) {
      emit(CounterState(state.value + 1));
    });

    on<CounterDecremented>((event, emit) {
      emit(CounterState(state.value - 1));
    });
  }
}
