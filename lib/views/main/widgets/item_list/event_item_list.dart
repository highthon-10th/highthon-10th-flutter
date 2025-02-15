import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/provider/event_provider.dart';
import 'package:highthon_10th/views/main/widgets/item_list/event_item.dart';

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
        return EventItem(
          event: events[index],
          locate: locate[index],
          fullLocate: fullLocate[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
