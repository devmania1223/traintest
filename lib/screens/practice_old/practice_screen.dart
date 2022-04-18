import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PracticeScreen extends StatefulWidget {
  PracticeScreen({Key key}) : super(key: key);

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  double progressValue = 75;

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
          'Practice Exercises',
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
      body: SingleChildScrollView(
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/problem');
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 20.0, right: 15.0),
                          decoration: new BoxDecoration(
                            color: Color(0xFF2F449B),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                        'assets/images/practice.png'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text('Pratice1',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900,
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 2, left: 10.0),
                                          child: Text(
                                            'present...',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Image.asset('assets/images/star.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/pratice2');
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 20.0, right: 15.0),
                          decoration: new BoxDecoration(
                            color: Color(0xFF2F449B),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                        'assets/images/practice.png'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text('Pratice2',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900,
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 2, left: 10.0),
                                          child: Text(
                                            'present perfect...',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Image.asset('assets/images/star.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/pratice3');
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 20.0, right: 15.0),
                          decoration: new BoxDecoration(
                            color: Color(0xFF2F449B),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                        'assets/images/practice.png'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text('Pratice3',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900,
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 2, left: 10.0),
                                          child: Text(
                                            'in fulltime...',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Image.asset('assets/images/star.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/pratice4');
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 20.0, right: 15.0),
                          decoration: new BoxDecoration(
                            color: Color(0xFF2F449B),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                        'assets/images/practice.png'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text('Pratice4',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900,
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 2, left: 10.0),
                                          child: Text(
                                            'present...',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Image.asset('assets/images/star.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/pratice5');
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 20.0, right: 15.0),
                          decoration: new BoxDecoration(
                            color: Color(0xFF2F449B),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                        'assets/images/practice.png'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text('Pratice5',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900,
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 2, left: 10.0),
                                          child: Text(
                                            'present...',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Image.asset('assets/images/star.png'),
                              ),
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
    );
  }
}
