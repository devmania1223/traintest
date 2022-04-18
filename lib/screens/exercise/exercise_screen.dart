import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:educa_feedback/widgets/loading_indicator.dart';

import 'package:educa_feedback/blocs/exercise/exercise_bloc.dart';

import 'package:educa_feedback/models/screen_arguments.dart';
// import 'package:educa_feedback/models/test.dart';

class ExerciseScreen extends StatefulWidget {

  ExerciseScreen({Key key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double value = 0;
  void initState() {
    context.read<ExerciseBloc>().add(FetchExercise());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            'Practice Exercise',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark
                ])),
          ),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pushNamed(context, '/');
           },
          )
        ),
        body: BlocBuilder<ExerciseBloc, ExerciseState>(
            builder: (context, state) {
              if (state is ExerciseError) {
                return Center(
                  child: Text(
                    'Couldn\'t load Exericse.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              }

              if (state is ExerciseLoading) {
                return LoadingIndicator(
                  size: 50.0,
                );
              }

              if (state is ExerciseLoaded) {
                final exercises = state.tests;

                if(exercises.isEmpty){
                  return Center(
                    child: Text(
                        "No Exercise yet!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold),                              
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.only(
                      top: 40.0, bottom: 30.0, left: 25.0, right: 25.0),
                  child: CustomScrollView(
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()
                      ),
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => index >= exercises.length ?
                            LoadingIndicator() : 
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context, '/exam',
                                    arguments: ScreenArguments(exercises[index].id, exercises[index].name,'Exercise'),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0, left: .0, right: 1.0),

                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, bottom: 20.0, left: 20.0, right: 15.0),
                                    decoration: new BoxDecoration(
                                      color: Color(0xFF2F449B),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child:
                                              Image.asset('assets/images/practice.png'),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  '${exercises[index].name}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ),
                            childCount: exercises.length,
                          ),

                        )
                      ],
                    ),
                  );
              }
              return Container();
            },
          ),
        
        );
  }
}
