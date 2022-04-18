import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import 'package:educa_feedback/blocs/grades/grades/grades_bloc.dart';
import 'package:educa_feedback/services/grades_api_client.dart';
import 'package:educa_feedback/screens/grades/grades_screen.dart';

import 'package:educa_feedback/repositories/grades_repository.dart';

class GradesWrapper extends StatelessWidget {
  const GradesWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = http.Client();

    final GradesRepository gradesRepository = GradesRepository(
      gradesApiClient: GradesApiClient(httpClient: client),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GradesBloc(gradesRepository: gradesRepository))
      ], 
      child: GradesScreen()
      );

  }
}
