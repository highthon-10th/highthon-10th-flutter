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
            /// 이벤트 이미지 (고정 크기)
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
            const SizedBox(width: 16),

            /// 텍스트 부분 (Expanded로 감싸기)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 이벤트 이름 (가로 오버플로우 방지)
                  Text(
                    event.eventName,
                    overflow: TextOverflow.ellipsis, // ...으로 표시
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color(0xFF3B3B3B),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Wanted',
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// 위치 정보 (Expanded 적용하여 오버플로우 방지)
                  Row(
                    children: [
                      const Icon(
                        Symbols.location_on_rounded,
                        color: Color(0xFF6E6E6E),
                        fill: 1,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          locate,
                          overflow: TextOverflow.ellipsis, // ...으로 표시
                          maxLines: 1,
                          style: const TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Wanted',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// 이벤트 시간 (Expanded 적용하여 오버플로우 방지)
                  Row(
                    children: [
                      const Icon(
                        Symbols.event_rounded,
                        color: Color(0xFF6E6E6E),
                        fill: 1,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.eventTime,
                          overflow: TextOverflow.ellipsis, // ...으로 표시
                          maxLines: 1,
                          style: const TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Wanted',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}