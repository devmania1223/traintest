
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/models/problem.dart';
import 'package:educa_feedback/blocs/exam/exam/exam_bloc.dart';
import 'package:educa_feedback/widgets/loading_indicator.dart';
import 'package:educa_feedback/widgets/problem/problem_card.dart';

// ignore: must_be_immutable
class ExamScreen extends StatefulWidget {

  final int testId;

  ExamScreen(
    {Key key, 
    @required this.testId})
     : super(key: key);

  @override
  _ExamScreenState createState() => _ExamScreenState();
}
enum Question { A, B, C, D }

class _ExamScreenState extends State<ExamScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  void initState() {
    context.read<ExamBloc>().add(FetchExam(testId: widget.testId));
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      // context.read<ExamBloc>().add(
      //       FetchExam(testId: widget.testId),
      //     );
    }
  }
  double progressValue = 75;
  List<Problem> problems = [];

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
          'Exam',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
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
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        backgroundColor: Color(0xFFBA509D),
        onPressed: () {
          Navigator.of(context).pushNamed('/score');
        },
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()
        ),

        slivers: <Widget>[
          BlocBuilder<ExamBloc, ExamState>(
            builder: (context, state){

              if (state is ExamError) {
                return SliverToBoxAdapter(
                  child: Text(
                    'Couldn\'t load Exam.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              }

              if (state is ExamLoading) {
                return SliverFillRemaining(
                  child: LoadingIndicator(size: 50.0,),
                );
              }

              if(state is ExamLoaded){
                problems = state.problems;

                if(state.problems.isEmpty){
                  return SliverFillRemaining(
                    child: Column(
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
                        SizedBox(height: 5.0,),
                        Text(
                          "Please contact to support team.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => index >= problems.length
                    ? LoadingIndicator()
                    :  AutomaticKeepAlive(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 10.0,
                          ),
                        child: ProblemCard(
                          index: index,
                          problem: problems[index]
                          ),
                      ),
                    ),
                    childCount: state.problems.length,
                  ),
                );
              }
              
              return SliverFillRemaining(
                child: LoadingIndicator(size: 21.0),
              );
            }
          ),
        ],
        
      )
    );
  }

}
