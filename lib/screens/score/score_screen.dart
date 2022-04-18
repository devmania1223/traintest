import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ScoreScreen extends StatefulWidget {
  ScoreScreen({Key key}) : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  double progressValue;

  @override
  Widget build(BuildContext context) {
    progressValue = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Score',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 0.0, right: 1.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Score",
                        style:
                            TextStyle(color: Color(0xFFBA509D), fontSize: 25.0),
                      ),
                      Column(
                        children: [
                          getGradientProgressStyle(),
                          const Text("Well Done!",
                              style: TextStyle(fontSize: 20.0))
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: const Text(
                          "You have completed the “Progress Test 1”.You can now check your strenghs and weakness, and then try again to improve those skills. Please note that you current score for this test won’t be affected after that.",
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/progress');
                            },
                            child: const Text(
                              "My Progress",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFBA509D),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getGradientProgressStyle() {
    return SizedBox(
        height: 200,
        width: 200,
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
