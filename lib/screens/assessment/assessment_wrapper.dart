import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:educa_feedback/blocs/assessment/assessment/assessment_bloc.dart';
import 'package:educa_feedback/blocs/assessment/access_code/access_code_bloc.dart';

import 'package:educa_feedback/repositories/assessment_repository.dart';
import 'package:educa_feedback/services/assessment_api_client.dart';

import 'package:educa_feedback/screens/assessment/assessment_screen.dart';

class AssessmentWrapper extends StatelessWidget {
  const AssessmentWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = http.Client();

    final AssessmentRepository assessmentRepository = AssessmentRepository(
      assessmentApiClient : AssessmentApiClient(httpClient: client),
    );

    return MultiBlocProvider(
      providers: [
      BlocProvider<AssessmentBloc>(
        create: (context) => AssessmentBloc(assessmentRepository: assessmentRepository)
      ),
      
      BlocProvider<AccessCodeBloc>(
        create: (context) => AccessCodeBloc(assessmentRepository: assessmentRepository)
      ),

    ], child: AssessmentScreen());

  }
}
