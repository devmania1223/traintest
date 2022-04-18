import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import 'package:educa_feedback/blocs/progress/progress/progress_bloc.dart';
import 'package:educa_feedback/services/progress_api_client.dart';
import 'package:educa_feedback/screens/progress/progress_screen.dart';

import 'package:educa_feedback/repositories/progress_repository.dart';

class ProgressWrapper extends StatelessWidget {
  const ProgressWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = http.Client();

    final ProgressRepository progressRepository = ProgressRepository(
      progressApiClient: ProgressApiClient(httpClient: client),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProgressBloc(progressRepository: progressRepository))
      ], 
      child: ProgressScreen()
      );

  }
}
