import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/screens/exam/exam_screen.dart';

import 'package:educa_feedback/blocs/exam/exam/exam_bloc.dart';
import 'package:educa_feedback/repositories/exam_repository.dart';
import 'package:educa_feedback/services/exam_api_client.dart';

import 'package:educa_feedback/blocs/exam/exam_result/exam_result_bloc.dart';

import 'package:educa_feedback/models/screen_arguments.dart';
class ExamWrapper extends StatelessWidget {
  const ExamWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = http.Client();

    final params = ModalRoute.of(context).settings.arguments as ScreenArguments;
    
    final ExamRepository examRepository = ExamRepository(
      examApiClient: ExamApiClient(httpClient: client),
    );

    return MultiBlocProvider(
      providers: [
      BlocProvider<ExamBloc>(
        create: (context) => ExamBloc(examRepository: examRepository)
      ),
      
      BlocProvider<ExamResultBloc>(
        create: (context) => ExamResultBloc(examRepository: examRepository)
      ),

    ], child: ExamScreen(testId: params.testId, testName: params.testName, type: params.type,));

  }
}
