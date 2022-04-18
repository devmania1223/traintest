import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/models/problem.dart';

import 'package:educa_feedback/blocs/exam/exam_result/exam_result_bloc.dart';
import 'package:educa_feedback/blocs/exam/exam/exam_bloc.dart';

import 'package:educa_feedback/widgets/loading_indicator.dart';

import 'package:simple_timer/simple_timer.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

// ignore: must_be_immutable
class ExamScreen extends StatefulWidget {
  final int testId;
  final String testName;
  final String type;
  ExamScreen(
      {Key key,
      @required this.testId,
      @required this.testName,
      @required this.type})
      : super(key: key);

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen>
    with SingleTickerProviderStateMixin {
  TimerController _timerController;
  TimerStyle _timerStyle = TimerStyle.ring;
  TimerProgressIndicatorDirection _progressIndicatorDirection =
      TimerProgressIndicatorDirection.clockwise;
  TimerProgressTextCountDirection _progressTextCountDirection =
      TimerProgressTextCountDirection.count_down;

  void initState() {
    context
        .read<ExamBloc>()
        .add(FetchExam(testId: widget.testId, type: widget.type));
    _timerController = TimerController(this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double progressValue = 75;
  List<Problem> problems = [];
  int _radioGroupValue = -1;
  int index = 0;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;

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
            '${widget.testName}',
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Warning!',
                    style: TextStyle(color: Color(0xFFBA509D)),
                  ),
                  content: Text("Do you want to exit the exam?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => {
                        _clickNextProblem(),
                        if (widget.type == "Exercise")
                          {Navigator.pushNamed(context, '/exercise')}
                        else if (widget.type == "Assessment")
                          {Navigator.pushNamed(context, '/assessment')}
                        else if (widget.type == "Progress")
                          {Navigator.pushNamed(context, '/progress')}
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        backgroundColor: Color(0xFFBA509D),
        onPressed: () {
          if ((problems[index].questionId == 2 && _radioGroupValue == -1) ||
              (problems[index].questionId == 1 &&
                  !isChecked1 &&
                  !isChecked2 &&
                  !isChecked3 &&
                  !isChecked4)) {
            return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Warning!',
                  style: TextStyle(color: Colors.red),
                ),
                content: Text(
                    "Student does not select answer.Do you want to really skip?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () =>
                        {_clickNextProblem(), Navigator.pop(context, 'Cancel')},
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else {
            _clickNextProblem();
          }
        },
      ),
      body: BlocListener<ExamResultBloc, ExamResultState>(
        listener: (context, state) {
          if (state is ExamResultSendingState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Theme.of(context).primaryColorDark,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sending...',
                      ),
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              );
          }

          if (state is ExamResultSendErrorState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.red,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Innernet Connection Error"),
                    ],
                  ),
                ),
              );
          }

          if (state is ExamResultLoadedState) {
            Navigator.pushNamed(context, '/score', arguments: state.score);
          }
        },
        child: BlocBuilder<ExamBloc, ExamState>(builder: (context, state) {
          if (state is ExamError) {
            return Text(
              'Couldn\'t load Exam.',
              style: Theme.of(context).textTheme.bodyText1,
            );
          }

          if (state is ExamLoading) {
            return LoadingIndicator(
              size: 50.0,
            );
          }

          if (state is ExamLoaded) {
            problems = state.problems;

            if (state.problems.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "No Problems yet!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Please contact to support team.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              );
            }

            _getThingsOnStartup().then((value) {
              print('Async done');
              _timerController.start();
            });

            return CustomScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: <Widget>[
                SliverFillRemaining(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                    child: state.problems[index].questionId == 1
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 230.0,
                                child: Stack(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 100),
                                        child: SizedBox(
                                          width: 250.0,
                                          child: DefaultTextStyle(
                                            style: const TextStyle(
                                                color: Color(0xFFBA509D),
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                            child: AnimatedTextKit(
                                              repeatForever: true,
                                              animatedTexts: [
                                                FlickerAnimatedText(
                                                    'On testing...',
                                                    speed: Duration(
                                                        milliseconds: 1000),
                                                    entryEnd: 0.7),
                                              ],
                                            ),
                                          ),
                                        )),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 230, right: 30),
                                      child: SimpleTimer(
                                        duration: const Duration(minutes: 15),
                                        controller: _timerController,
                                        timerStyle: _timerStyle,
                                        onStart: handleTimerOnStart,
                                        onEnd: handleTimerOnEnd,
                                        // valueListener: timerValueChangeListener,
                                        backgroundColor: Colors.grey,
                                        progressIndicatorColor:
                                            Color(0xFFBA509D),
                                        progressIndicatorDirection:
                                            _progressIndicatorDirection,
                                        progressTextCountDirection:
                                            _progressTextCountDirection,
                                        progressTextStyle: TextStyle(
                                            color: Colors.black, fontSize: 50),
                                        strokeWidth: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "${index + 1}" +
                                    ". ${state.problems[index].content}",
                                style: TextStyle(
                                    color: Color(0xFFBA509D), fontSize: 18.0),
                              ),
                              CheckboxListTile(
                                  activeColor: Color(0xFFBA509D),
                                  checkColor: Colors.white,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title:
                                      Text('${state.problems[index].choose1}'),
                                  value: isChecked1,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked1 = value;
                                      print(value);
                                    });
                                  }),
                              CheckboxListTile(
                                  activeColor: Color(0xFFBA509D),
                                  checkColor: Colors.white,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title:
                                      Text('${state.problems[index].choose2}'),
                                  value: isChecked2,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked2 = value;
                                    });
                                  }),
                              CheckboxListTile(
                                  activeColor: Color(0xFFBA509D),
                                  checkColor: Colors.white,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title:
                                      Text('${state.problems[index].choose3}'),
                                  value: isChecked3,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked3 = value;
                                    });
                                  }),
                              CheckboxListTile(
                                  activeColor: Color(0xFFBA509D),
                                  checkColor: Colors.white,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title:
                                      Text('${state.problems[index].choose4}'),
                                  value: isChecked4,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked4 = value;
                                    });
                                  }),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 230.0,
                                child: Stack(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 100),
                                        child: SizedBox(
                                          width: 250.0,
                                          child: DefaultTextStyle(
                                            style: const TextStyle(
                                                color: Color(0xFFBA509D),
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                            child: AnimatedTextKit(
                                              repeatForever: true,
                                              animatedTexts: [
                                                FlickerAnimatedText(
                                                    'On testing...',
                                                    speed: Duration(
                                                        milliseconds: 1000),
                                                    entryEnd: 0.7),
                                              ],
                                            ),
                                          ),
                                        )),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 230, right: 30),
                                      child: SimpleTimer(
                                        duration: const Duration(minutes: 30),
                                        controller: _timerController,
                                        timerStyle: _timerStyle,
                                        onStart: handleTimerOnStart,
                                        onEnd: handleTimerOnEnd,
                                        // valueListener: timerValueChangeListener,
                                        backgroundColor: Colors.grey,
                                        progressIndicatorColor:
                                            Color(0xFFBA509D),
                                        progressIndicatorDirection:
                                            _progressIndicatorDirection,
                                        progressTextCountDirection:
                                            _progressTextCountDirection,
                                        progressTextStyle: TextStyle(
                                            color: Colors.black, fontSize: 50),
                                        strokeWidth: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "${index + 1}" +
                                    ". ${state.problems[index].content}",
                                style: TextStyle(
                                    color: Color(0xFFBA509D), fontSize: 18.0),
                              ),
                              RadioListTile(
                                title: Text('${state.problems[index].choose1}'),
                                value: 1,
                                groupValue: _radioGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    _radioGroupValue = value;
                                  });
                                },
                                activeColor: const Color(0xFF2F449B),
                              ),
                              RadioListTile(
                                title: Text('${state.problems[index].choose2}'),
                                value: 2,
                                groupValue: _radioGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    _radioGroupValue = value;
                                  });
                                },
                                activeColor: const Color(0xFF2F449B),
                              ),
                              RadioListTile(
                                title: Text('${state.problems[index].choose3}'),
                                value: 3,
                                groupValue: _radioGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    _radioGroupValue = value;
                                  });
                                },
                                activeColor: const Color(0xFF2F449B),
                              ),
                              RadioListTile(
                                title: Text('${state.problems[index].choose4}'),
                                value: 4,
                                groupValue: _radioGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    _radioGroupValue = value;
                                  });
                                },
                                activeColor: const Color(0xFF2F449B),
                              ),
                            ],
                          ),
                  ),
                )
              ],
            );
          }

          return Container();
          // return SliverFillRemaining(
          //   child: LoadingIndicator(size: 21.0),
          // );
        }),
      ),
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }

  void _clickNextProblem() {
    if ((index + 1) == problems.length) {
      setState(() {
        if (problems[index].questionId == 1) {
          problems[index].answer1 = isChecked1;
          problems[index].answer2 = isChecked2;
          problems[index].answer3 = isChecked3;
          problems[index].answer4 = isChecked4;

          isChecked1 = false;
          isChecked2 = false;
          isChecked3 = false;
          isChecked4 = false;
        } else {
          problems[index].answer1 = _radioGroupValue == 1 ? true : false;
          problems[index].answer2 = _radioGroupValue == 2 ? true : false;
          problems[index].answer3 = _radioGroupValue == 3 ? true : false;
          problems[index].answer4 = _radioGroupValue == 4 ? true : false;

          _radioGroupValue = -1;
        }
      });
      _timerController.dispose();
      context
          .read<ExamResultBloc>()
          .add(SendExamResultEvent(problems: problems, type: widget.type));
    } else {
      setState(() {
        if (problems[index].questionId == 1) {
          problems[index].answer1 = isChecked1;
          problems[index].answer2 = isChecked2;
          problems[index].answer3 = isChecked3;
          problems[index].answer4 = isChecked4;

          isChecked1 = false;
          isChecked2 = false;
          isChecked3 = false;
          isChecked4 = false;
        } else {
          problems[index].answer1 = _radioGroupValue == 1 ? true : false;
          problems[index].answer2 = _radioGroupValue == 2 ? true : false;
          problems[index].answer3 = _radioGroupValue == 3 ? true : false;
          problems[index].answer4 = _radioGroupValue == 4 ? true : false;

          _radioGroupValue = -1;
        }
        index = index + 1;
      });
    }
  }

  void handleTimerOnStart() {
    print("timer has just started");
  }

  void handleTimerOnEnd() {
    _clickNextProblem();
    print("timer has ended");
  }
}
