part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final int todayQueueCount;
  final int todayBookingCount;

  const HomeState({
    this.isLoading = false,
    this.todayQueueCount = 0,
    this.todayBookingCount = 0,
  });

  @override
  List<Object> get props => [isLoading, todayQueueCount, todayBookingCount];
}
