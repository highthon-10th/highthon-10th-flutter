import 'package:highthon_10th/commons/dio.dart';
import 'package:highthon_10th/models/event_model.dart';
import 'package:highthon_10th/models/visit_model.dart';

class EventRepository {
  static Future<List<EventModel>> getEventList() async {
    final response = await dio.get('events/');

    print(response.data);

    List<EventModel> eventList = (response.data as List)
        .map((event) => EventModel.fromJson(event))
        .toList();

    return eventList;
  }
}
