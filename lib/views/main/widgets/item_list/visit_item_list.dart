import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/provider/visit_provider.dart';
import 'package:highthon_10th/views/main/widgets/item_list/visit_item.dart';

class VisitItemList extends ConsumerWidget {
  const VisitItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visits = ref.watch(visitProvider);
    const List<String> shortLocates = [
      '서울특별시 종로구',
      '서울특별시 종로구',
      '서울특별시 강남구',
      '서울특별시 영등포구',
      '서울특별시 서초구',
      '서울특별시 마포구',
      '서울특별시 마포구',
      '서울특별시 중구',
      '서울특별시 종로구',
      '서울특별시 중구',
    ];

    const List<String> fullLocates = [
      '서울특별시 종로구 자하문로5가길 19',
      '서울특별시 종로구 자하문로7길 대오서점',
      '서울특별시 강남구 학동로20길 택사스돈까스',
      '서울특별시 영등포구 여의대방로69길 여의도따로국밥',
      '서울특별시 서초구 신반포로11길 40',
      '서울특별시 마포구 상암동 1610',
      '서울특별시 마포구 월드컵북로 456',
      '서울특별시 중구 삼일대로12길 혜민당',
      '서울특별시 종로구 북촌로5나길 30',
      '서울특별시 중구 덕수궁길 15',
    ];
    return ListView.separated(
      shrinkWrap: true,
      itemCount: visits.length,
      itemBuilder: (context, index) {
        return VisitItem(
          visit: visits[index],
          locate: shortLocates[index],
          fullLocate: fullLocates[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
