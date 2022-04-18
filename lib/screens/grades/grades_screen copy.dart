import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:educa_feedback/blocs/grades/grades/grades_bloc.dart'

;
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 50.0,
                ),
                children: <Widget>[
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset('assets/images/test.png'),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text('Quick Test 1 ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          )),
                                      Text(
                                        'AA1DX | 04/04/2021',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: const Text(
                                    '78%',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
