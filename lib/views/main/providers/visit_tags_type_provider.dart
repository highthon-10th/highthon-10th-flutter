import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum VisitTagsType {
  all(null, Colors.black, '전체'),
  food(
    Symbols.restaurant_rounded,
    Color(0xFFFB467B),
    '식당',
  ),
  park(
    Symbols.park_rounded,
    Color(0xFFB051FB),
    '공원',
  ),
  cafe(
    Symbols.local_cafe_rounded,
    Color(0xFF9496FA),
    '카페',
  ),
  etc(
    Symbols.home_rounded,
    Color(0xFFFF6DB6),
    '기타',
  );

  const VisitTagsType(this.icon, this.color, this.text);

  final IconData? icon;
  final Color color;
  final String text;
}

final eventTagsTypeProvider =
    StateProvider<VisitTagsType>((ref) => VisitTagsType.all);
