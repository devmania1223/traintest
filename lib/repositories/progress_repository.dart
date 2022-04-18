import 'package:educa_feedback/models/progress.dart';
import 'package:educa_feedback/models/progress_bar.dart';
import 'package:educa_feedback/services/progress_api_client.dart';

class ProgressRepository {
  final ProgressApiClient progressApiClient;

  ProgressRepository({ProgressApiClient progressApiClient})
      : progressApiClient = progressApiClient ?? ProgressApiClient();

  Future<Progress> getProgressInfo() async {
    return await progressApiClient.fetchProgressInfo();
  }

  Future<ProgressBar> getProgressBarInfo() async {
    return await progressApiClient.getProgressBarInfo();
  }
}
