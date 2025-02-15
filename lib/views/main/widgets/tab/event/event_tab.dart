import 'package:flutter/material.dart';
import 'package:highthon_10th/views/main/widgets/item_list/event_item_list.dart';

class EventTab extends StatelessWidget {
  const EventTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: EventItemList(),
    );
  }
}
