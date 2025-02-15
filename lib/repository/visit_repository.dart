import 'package:highthon_10th/commons/dio.dart';
import 'package:highthon_10th/models/visit_model.dart';

class VisitRepository {
  static Future<List<VisitModel>> getVisitList() async {
    final response = await dio.get('visits/');

    print(response.data);

    List<VisitModel> eventList = (response.data as List)
        .map((event) => VisitModel.fromJson(event))
        .toList();

    return eventList;
  }
}
