import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AssessmentScreen extends StatefulWidget {
  AssessmentScreen({Key key}) : super(key: key);

  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
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
          'My Assessments',
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                  child: Container(
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
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset('assets/images/test.png'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                  child: Container(
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
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset('assets/images/test.png'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Quick Test 2 ',
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
                                  '86%',
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                  child: Container(
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
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset('assets/images/test.png'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Quick Test 3 ',
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
                                  '100%',
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                  child: Container(
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
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset('assets/images/test.png'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Quick Test 4 ',
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
                                child: TextButton(
                                  child: const Text(
                                    'START',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF2F449B)),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                          'ACCESS CODE',
                                          style: TextStyle(
                                            color: Color(0xFFBA509D),
                                          ),
                                        ),
                                        content: const TextField(
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF2F449B)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF2F449B)),
                                            ),
                                            labelText: 'Code',
                                            labelStyle: TextStyle(
                                              color: Color(0xFF2F449B),
                                            ),
                                            hintText: 'Enter Access Code',
                                            hintStyle: TextStyle(
                                              color: Color(0xFF2F449B),
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => {
                                              Navigator.of(context)
                                                  .pushNamed('/test')
                                            },
                                            child: const Text(
                                              'START',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF2F449B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                  child: Container(
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
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset('assets/images/test.png'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Quick Test 5 ',
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
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset('assets/images/rock.png'),
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
    );
  }

}
