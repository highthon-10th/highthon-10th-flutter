import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:highthon_10th/provider/event_provider.dart';
import 'package:highthon_10th/views/main/main_screen.dart';
import 'package:highthon_10th/views/main/widgets/item_list/event_item.dart';
import 'package:highthon_10th/views/main/widgets/modal/map_modal.dart';

class EventItemList extends ConsumerWidget {
  const EventItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventProvider);
    final locate = [
      '서울특별시 마포구',
      '서울특별시 마포구',
      '서울특별시 강남구',
    ];

    final fullLocate = [
      '서울특별시 마포구 와우산로15길 37',
      '서울특별시 마포구 양화로 153',
      '서울특별시 강남구 강남대로110길 21'
    ];
    return ListView.separated(
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            final CameraPosition _kLake = CameraPosition(
                target: LatLng(events[index].latitude, events[index].longitude),
                zoom: 19.151926040649414);
            googleMapController!.animateCamera(CameraUpdate.newCameraPosition(_kLake));
            showDialog(
              context: context,
              builder: (builder) => EventModal(
                events[index],
                fullLocate[index],
                locate[index],
              ),
            );
          },
          child: EventItem(
            event: events[index],
            locate: locate[index],
            fullLocate: fullLocate[index],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
