import 'package:flutter/material.dart';
import 'package:highthon_10th/views/main/providers/visit_tags_type_provider.dart';
import 'package:highthon_10th/views/main/widgets/item_list/visit_item_list.dart';

class VisitTab extends StatelessWidget {
  const VisitTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 28,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: VisitTagsType.values.length,
              itemBuilder: (context, index) {
                return _TabItem(
                  VisitTagsType.values.elementAt(index),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
            ),
          ),
          const SizedBox(height: 16),
          VisitItemList(),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem(this.type);

  final VisitTagsType type;

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
          ],
          Text(
            type.text,
            style: TextStyle(
              color: type.color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Wanted',
            ),
          ),
        ],
      ),
    );
  }
}
