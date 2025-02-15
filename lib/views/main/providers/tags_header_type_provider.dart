import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TagsHeaderType {
  pick,
  event,
}

final tagsHeaderTypeProvider = StateProvider<TagsHeaderType>((ref) => TagsHeaderType.pick);
