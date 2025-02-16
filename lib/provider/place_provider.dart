import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/models/place_model.dart';
import '../repository/register_repository.dart';

final placeRepositoryProvider = Provider((ref) => PlaceRepository());

final placeListProvider =
    StateNotifierProvider<PlaceNotifier, List<PlaceModel>>((ref) {
  final repository = ref.read(placeRepositoryProvider);
  return PlaceNotifier(repository);
});

class PlaceNotifier extends StateNotifier<List<PlaceModel>> {
  final PlaceRepository repository;

  PlaceNotifier(this.repository) : super([]);

  Future<void> addPlace(PlaceModel place, WidgetRef ref) async {
    try {
      await repository.addPlace(place,ref);
      state = [...state, place];
    } catch (e) {
      print('Error adding place: $e');
    }
  }
}