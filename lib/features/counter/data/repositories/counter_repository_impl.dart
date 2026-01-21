import 'package:third_queue_booking_app/features/counter/data/datasources/counter_remote_data_source.dart';
import 'package:third_queue_booking_app/features/counter/domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CounterRemoteDataSource remote;

  CounterRepositoryImpl(this.remote);

  @override
  Future<int> getTodayCounterCount() async {
    final model = await remote.fetchTodaySummary();
    return model.count;
  }
}
