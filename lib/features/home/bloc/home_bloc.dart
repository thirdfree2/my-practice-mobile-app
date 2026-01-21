import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:third_queue_booking_app/features/counter/domain/repositories/counter_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CounterRepository queueRepository;
  final CounterRepository bookingRepository;

  HomeBloc({required this.queueRepository, required this.bookingRepository})
    : super(const HomeState()) {
    on<HomeStarted>(_onStarted);
  }

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {}
}
