import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/models/place_model.dart';
import 'package:highthon_10th/provider/token.dart';
import '../commons/dio.dart';

class PlaceRepository {
  Future<String> addPlace(PlaceModel place, WidgetRef ref) async {
    final tokenRef = ref.read(token);
    print(tokenRef);
    try {
      final response = await dio.post('visits/',
          data: place.toJson(),
          options: Options(headers: {'Authorization': "Bearer $tokenRef"}));
      return response.data['id'];
    } catch (e) {
      throw Exception('Failed to add place: $e');
    }
  }
}

class VisitRepository {
  Future<void> uploadVisit(VisitModel visit,WidgetRef ref) async {
    final tokenRef = ref.read(token);
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(visit.file.path),
      });

      await dio.post('visits/image/',
          queryParameters: {
            'favorite_member': visit.favoriteMember,
            'visit_id': visit.visitId,
          },
          data: formData,
          options: Options(headers: {'Authorization':  "Bearer $tokenRef"}));
    } catch (e) {
      throw Exception('Failed to upload visit: $e');
    }
  }
}
