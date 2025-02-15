import 'package:flutter/material.dart';
import 'package:highthon_10th/models/event_model.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    super.key,
    required this.event,
    required this.locate,
    required this.fullLocate,
  });

  final EventModel event;
  final String locate;
  final String fullLocate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF7A618D).withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(event.photoUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventName,
                  style: TextStyle(
                      color: Color(0xFF3B3B3B),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Wanted'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Symbols.location_on_rounded,
                      color: Color(0xFF6E6E6E),
                      fill: 1,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      locate,
                      style: TextStyle(
                        color: Color(0xFF6E6E6E),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Wanted',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Symbols.event_rounded,
                      color: Color(0xFF6E6E6E),
                      fill: 1,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(event.eventTime)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
