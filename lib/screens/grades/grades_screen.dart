import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:educa_feedback/blocs/grades/grades/grades_bloc.dart';

import 'package:educa_feedback/widgets/loading_indicator.dart';


class GradesScreen extends StatefulWidget {
  GradesScreen({Key key}) : super(key: key);

  @override
  _GradesScreenState createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {

  @override
  void initState() {
    context.read<GradesBloc>().add(FetchGrades());
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
          'Grades',
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
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.pushNamed(context, '/');
          },
        )
      ),
      body: Container(
        child: BlocBuilder<GradesBloc, GradesState>(
          builder: (context, state) {
            if(state is GradesError){
              return Center(
                child: Text(
                  'Couldn\'t load Exericse.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            }

            if (state is GradesLoading) {
              return LoadingIndicator(
                size: 50.0,
              );
            }

            if (state is GradesLoaded){
              final grades = state.grades;

              if(grades.isEmpty){
                return Center(
                  child: Text(
                      "No Exercises yet!",
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
                    top: 40.0, bottom: 25.0, left: 25.0, right: 25.0),
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                
                  slivers: <Widget>[

                      SliverList(delegate: SliverChildBuilderDelegate(
                        (context, index) => index >= grades.length ?
                        LoadingIndicator() :
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 20.0,
                                      right: 15.0),
                                  decoration: new BoxDecoration(
                                    color: Color(0xFF2F449B),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.asset('assets/images/test.png'),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('${grades[index].name}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                )),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   alignment: Alignment.centerRight,
                                      //   padding: const EdgeInsets.only(left: 10.0),
                                      //   child: const Text(
                                      //     '78%',
                                      //     style: TextStyle(
                                      //         color: Colors.white, fontSize: 30),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        childCount: grades.length
                      ),
                    )
                  ],
                )
              );
            }

            return Container();

          },
        )
      ),
    );
  }

}
