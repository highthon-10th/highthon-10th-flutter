import 'package:flutter/material.dart';
import 'package:highthon_10th/views/main/providers/event_tags_type_provider.dart';

class EventTab extends StatelessWidget {
  const EventTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: EventTagsType.values.map((e) => _TabItem(e)).toList(),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem(this.type);

  final EventTagsType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (type.icon != null) ...[
            Icon(
              type.icon,
              color: type.color,
              fill: 1,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              type.text,
              style: TextStyle(
                color: type.color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Wanted'
              ),
            ),
          ]
        ],
      ),
    );
  }
}
