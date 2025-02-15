import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/models/visit_model.dart';
import 'package:highthon_10th/repository/visit_repository.dart';

final visitProvider = StateNotifierProvider<VisitProvider, List<VisitModel>>((ref) => VisitProvider());

class VisitProvider extends StateNotifier<List<VisitModel>>{
  VisitProvider() : super([]);

  Future<void> loadVisits() async {
    final response = await VisitRepository.getVisitList();

    state = response;
  }
}
