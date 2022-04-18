
import 'package:educa_feedback/models/exam.dart';
import 'package:educa_feedback/services/exam_api_client.dart';

class ExamRepository {
  final ExamApiClient examApiClient;

  ExamRepository({ExamApiClient examApiClient})
      : examApiClient = examApiClient ?? ExamApiClient();

  Future<Exam> getExamInfo(testId, type) async {
    return await examApiClient.fetchExamInfo(testId, type);
  }

  Future<double> sendExamResult(problems, type) async {
    return await examApiClient.sendExamResult(problems, type);
  }
}
