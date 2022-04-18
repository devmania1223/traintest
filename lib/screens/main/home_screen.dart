import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/auth_profile/auth_profile_bloc.dart';
import 'package:educa_feedback/blocs/progress/progress_bar/progress_bar_bloc.dart';
import 'package:educa_feedback/widgets/nav/nav_drawer.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'package:motion_toast/resources/arrays.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // AnimationController _animationController;
  final _scrollController = ScrollController();

  int counter = 2;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<AuthProfileBloc>().add(FetchAuthProfile());
    context.read<ProgressBarBloc>().add(FetchProgressBar());
    
    // context.read<AuthProfileBloc>().add(
    //       GetAvatar(),
    //     );
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    // _animationController.dispose();
    super.dispose();
  }

  // void _displayErrorMotionToast() {
  //   MotionToast.error(
  //     title: Text(
  //       'Title',
  //       style: TextStyle(
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     description: Text('Content'),
  //     animationType: ANIMATION.fromRight,
  //     position: MOTION_TOAST_POSITION.top,
  //     width: 300,
  //   ).show(context);
  // }

  void changePage(int index) {
    // _animationController.forward(from: 0);
    setState(() {
      _pageController.jumpToPage(index);
    });
    if (index == 2) {
      // context.read<NotificationBloc>().add(ResetNotificationCounts());
    }
  }

  // List<Tweet> tweets = [];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: NavDrawer('/'),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75.0), // here the desired height
        child: AppBar(
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10),
            child: SizedBox(
              height: 55,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          actions: <Widget>[
            // InkWell(
            //   onTap: () {
            //     _displayErrorMotionToast();
            //     setState(() {
            //       counter = 0;
            //     });
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.only(top: 15.0, bottom: 10),
            //     child: Stack(
            //       children: <Widget>[
            //         IconButton(
            //           icon: const Icon(
            //             Icons.notifications,
            //             color: Colors.white,
            //             size: 30.0,
            //           ),
            //           onPressed: () {},
            //         ),
            //         counter != 0
            //             ? Positioned(
            //                 right: 11,
            //                 top: 11,
            //                 child: new Container(
            //                   padding: const EdgeInsets.all(2),
            //                   decoration: new BoxDecoration(
            //                     color: Colors.red,
            //                     borderRadius: BorderRadius.circular(6),
            //                   ),
            //                   constraints: const BoxConstraints(
            //                     minWidth: 14,
            //                     minHeight: 14,
            //                   ),
            //                   child: Text(
            //                     '$counter',
            //                     style: const TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 8,
            //                     ),
            //                     textAlign: TextAlign.center,
            //                   ),
            //                 ),
            //               )
            //             : Container()
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 10),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
          ],
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
                  top: 30.0,
                ),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<AuthProfileBloc, AuthProfileState>(
                              builder: (context, state) {
                            if (state is AuthProfileLoaded) {
                              return Text("Hello ${state.user.name}!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black));
                            }
                            return Container(
                              height: 20,
                            );
                          })

                          /*SizedBox(
                            width: 90,
                            height: 90,
                            child: Image.asset('assets/images/level_10.png'),
                          )*/
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<ProgressBarBloc, ProgressBarState>(
                    builder: (context, state) {
                      if(state is ProgressBarLoaded){
                        return Container(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      getGradientProgressStyle(state.courseProgress.toDouble()),
                                      Text("Course Progress")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      getGradientProgressStyle(state.myProgress.toDouble()),
                                      Text("My Progress")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                      }

                      return Container(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Column(
                                    children: [
                                      getGradientProgressStyle(0.0),
                                      Text("Course Progress")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      getGradientProgressStyle(0.0),
                                      Text("My Progress")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                    }
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/exercise');
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: .0, right: 1.0),
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
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child:
                                      Image.asset('assets/images/practice.png'),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Practice Exercises ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/assessment');
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: .0, right: 1.0),
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
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset('assets/images/test.png'),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Assessments ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/progress');
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: .0, right: 1.0),
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
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child:
                                      Image.asset('assets/images/progress.png'),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'My Progress ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }

  /// Returns gradient progress style circular progress bar.
  Widget getGradientProgressStyle(progressValue) {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              axisLineStyle: AxisLineStyle(
                thickness: 0.1,
                color: const Color.fromARGB(30, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
                cornerStyle: CornerStyle.startCurve,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                    value: progressValue,
                    width: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationDuration: 100,
                    animationType: AnimationType.linear,
                    cornerStyle: CornerStyle.startCurve,
                    gradient: const SweepGradient(
                        colors: <Color>[Color(0xFF9D1C63), Color(0xFFCE93B3)],
                        stops: <double>[0.25, 0.75])),
                MarkerPointer(
                  value: progressValue,
                  markerType: MarkerType.circle,
                  enableAnimation: true,
                  animationDuration: 100,
                  animationType: AnimationType.linear,
                  color: const Color(0xFF9D1C63),
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0,
                    widget: Text(
                      progressValue.toStringAsFixed(0) + '%',
                      style: const TextStyle(fontSize: 20),
                    ))
              ]),
        ]));
  }
}
