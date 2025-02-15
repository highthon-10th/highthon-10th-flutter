import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/views/main/providers/tags_header_type_provider.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class HeaderItem extends ConsumerWidget {
  const HeaderItem({
    super.key,
    required this.title,
    required this.type,
  });

  final String title;
  final TagsHeaderType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsType = ref.watch(tagsHeaderTypeProvider);
    return GestureDetector(
      onTap: tagsType != type ? () {
        ref.read(tagsHeaderTypeProvider.notifier).state = type;
      } : null,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(tagsType == type ? 1 : 0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (tagsType == type) ...[
              Icon(
                Symbols.favorite_rounded,
                color: Color(0xFFB051FB),
                fill: 1,
                size: 24,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              title,
              style: TextStyle(
                color: tagsType == type ? Color(0xFFB051FB) : Colors.black,
                fontSize: 16,
                fontWeight: tagsType == type ? FontWeight.w800 : FontWeight.w600,
                fontFamily: 'Wanted',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
