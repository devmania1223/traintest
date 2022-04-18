
import 'package:educa_feedback/models/assessment.dart';
import 'package:educa_feedback/services/assessment_api_client.dart';

class AssessmentRepository {
  final AssessmentApiClient assessmentApiClient;

  AssessmentRepository({AssessmentApiClient assessmentApiClient})
      : assessmentApiClient = assessmentApiClient ?? AssessmentApiClient();

  Future<Assessment> getAssessmentInfo() async {
    return await assessmentApiClient.fetchAssessmentInfo();
  }

  Future<bool> verifyAccessCode(assessmentId, accessCode) async {
    return await assessmentApiClient.verifyAccessCode(assessmentId, accessCode);
  }
}
