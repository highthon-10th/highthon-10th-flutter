import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/models/event_model.dart';
import 'package:highthon_10th/repository/event_repository.dart';


final eventProvider = StateNotifierProvider<EventProvider, List<EventModel>>((ref) => EventProvider());

class EventProvider extends StateNotifier<List<EventModel>>{
  EventProvider() : super([]);

  Future<void> loadEvents() async {
    final response = await EventRepository.getEventList();

    state = response;
  }
}
