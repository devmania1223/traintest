import 'package:educa_feedback/blocs/grades/grades/grades_bloc.dart';
import 'package:educa_feedback/repositories/grades_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/screens/grades/grades_screen.dart';
import 'package:educa_feedback/screens/screens.dart';
import 'package:educa_feedback/theme/app_theme.dart';
import 'package:educa_feedback/theme/bloc/theme_bloc.dart';
import 'package:educa_feedback/repositories/repositories.dart';
import 'package:educa_feedback/blocs/blocs.dart';

class Tweety extends StatefulWidget {
  final UserRepository userRepository;
  final ContactRepository contactRepository;

  final ExerciseRepository exerciseRepository;
  final ProgressRepository progressRepository;
  final GradesRepository gradesRepository;


  const Tweety({
    Key key,
    this.userRepository,
    this.contactRepository, 
    this.exerciseRepository,
    this.progressRepository,
    this.gradesRepository,
  }) : super(key: key);

  @override
  _TweetyState createState() => _TweetyState();
}

class _TweetyState extends State<Tweety> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc =
        AuthenticationBloc(userRepository: widget.userRepository);
    _authenticationBloc.add(AuthenticationStarted());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<AuthProfileBloc>(
          create: (context) =>
              AuthProfileBloc(userRepository: widget.userRepository),
        ),
        BlocProvider<ProgressBarBloc>(
          create: (context) =>
              ProgressBarBloc(progressRepository: widget.progressRepository),
        ),
        BlocProvider<GradesBloc>(
          create: (context) =>
              GradesBloc(gradesRepository: widget.gradesRepository),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) =>
              ProfileBloc(userRepository: widget.userRepository),
        ),

        BlocProvider<ExerciseBloc>(
          create: (context) =>
              ExerciseBloc(exerciseRepository: widget.exerciseRepository),
        ),
        BlocProvider<ContactBloc>(
          create: (context) =>
              ContactBloc(contactRepository: widget.contactRepository),
        ),
      ],
      child: _buildWithTheme(context),
    );
  }

  Widget _buildWithTheme(BuildContext context) {
    return 
    BlocBuilder<ThemeBloc, AppTheme>(
      builder: (context, appTheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Educa',
          theme: appThemeData[appTheme],
          routes: {
            '/': (context) {
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is AuthenticationFailure) {
                  return LoginWrapper(userRepository: widget.userRepository);
                }
                if (state is AuthenticationSuccess) {
                  return HomeScreen();
                }
                return SplashScreen();
              });
            },
            '/forgot-password': (context) => ForgotPasswordScreen(),
            '/forgot-code': (context) => ForgotCodeScreen(),
                       
            '/profile': (context) => ProfileWrapper(),
            '/calendar': (context) => CalendarScreen(),
            '/grades': (context) => GradesScreen(),
            '/notifications': (context) => NotificationsScreen(),
            '/contact': (context) => ContactScreen(),
            
            '/assessment': (context) => AssessmentWrapper(),
            '/progress': (context) => ProgressWrapper(),
            '/exercise': (context) => ExerciseWrapper(),
            
            '/exam': (context) => ExamWrapper(),
            '/score': (context) => ScoreScreen(),

          },
        );
      },
    );
  }
}
