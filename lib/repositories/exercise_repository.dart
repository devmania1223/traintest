import 'package:educa_feedback/models/exercise.dart';
import 'package:educa_feedback/services/exercise_api_client.dart';

class ExerciseRepository {
  final ExerciseApiClient exerciseApiClient;

  ExerciseRepository({ExerciseApiClient exerciseApiClient})
      : exerciseApiClient = exerciseApiClient ?? ExerciseApiClient();

  Future<Exercise> getExerciseInfo() async {
    return await exerciseApiClient.fetchExerciseInfo();
  }
}
