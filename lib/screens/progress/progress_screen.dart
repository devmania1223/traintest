import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:educa_feedback/blocs/progress/progress/progress_bloc.dart';
import 'package:educa_feedback/blocs/progress/progress_bar/progress_bar_bloc.dart';

import 'package:educa_feedback/widgets/accordion/progress_accordion.dart';

import 'package:educa_feedback/widgets/loading_indicator.dart';

class ProgressScreen extends StatefulWidget {
  ProgressScreen({Key key}) : super(key: key);

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {

  @override
  void initState() {
    context.read<ProgressBloc>().add(FetchProgress());
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
          'My Progress',
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
      body: BlocBuilder<ProgressBloc, ProgressState>(
        builder: (context, state) {
          if(state is ProgressError){
            return Center(
              child: Text(
                'Couldn\'t load Exericse.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          }

          if (state is ProgressLoading) {
            return LoadingIndicator(
              size: 50.0,
            );
          }

          if (state is ProgressLoaded){
            final progress = state.topics;

            if(progress.isEmpty){
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
                      (context, index) => Container(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: .0, right: 1.0),
                        child: BlocBuilder<ProgressBarBloc, ProgressBarState>(
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
                      ),

                      childCount: 1
                    )),
                    SliverList(delegate: SliverChildBuilderDelegate(
                      (context, index) => index >= progress.length ?
                      LoadingIndicator() :
                      ProgressAccordion(progress[index]),
                      childCount: progress.length
                    ),
                  )
                ],
              )
            );
          }

          return Container();

        },
      )

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
