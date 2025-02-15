import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/views/main/providers/tags_header_type_provider.dart';
import 'package:highthon_10th/views/main/widgets/header/header_item.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class MainTagsHeader extends ConsumerWidget {
  const MainTagsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              HeaderItem(
                type: TagsHeaderType.pick,
                title: '아이유 PICK!',
              ),
              const SizedBox(width: 8),
              HeaderItem(
                type: TagsHeaderType.event,
                title: '이벤트',
              ),
            ],
          ),
          _MyButton(),
        ],
      ),
    );
  }
}

class _MyButton extends StatelessWidget {
  const _MyButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Symbols.person_rounded,
          color: Color(0xFF3B3B3B),
          size: 28,
          fill: 1,
        ),
      ),
    );
  }
}
