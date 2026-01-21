import 'package:third_queue_booking_app/core/network/api_client.dart';
import 'package:third_queue_booking_app/features/counter/data/models/counter_summary_model.dart';

class CounterRemoteDataSource {
  final ApiClient client;

  CounterRemoteDataSource(this.client);

  Future<CounterSummaryModel> fetchTodaySummary() async {
    final res = await client.get('/counter/today');
    return CounterSummaryModel.fromJson(res);
  }
}
