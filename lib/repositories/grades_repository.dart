import 'package:educa_feedback/models/grades.dart';
import 'package:educa_feedback/services/grades_api_client.dart';

class GradesRepository {
  final GradesApiClient gradesApiClient;

  GradesRepository({GradesApiClient gradesApiClient})
      : gradesApiClient = gradesApiClient ?? GradesApiClient();

  Future<Grades> getGradesInfo() async {
    return await gradesApiClient.fetchGradesInfo();
  }

}
