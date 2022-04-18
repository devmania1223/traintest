import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/assessment/access_code/access_code_bloc.dart';
import 'package:educa_feedback/blocs/assessment/assessment/assessment_bloc.dart';

import 'package:educa_feedback/models/screen_arguments.dart';
import 'package:educa_feedback/widgets/loading_indicator.dart';

class AssessmentScreen extends StatefulWidget {

  AssessmentScreen({Key key}) : super(key: key);

  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  AccessCodeBloc _accessCodeBloc;
  int currentId = -1;

  int rockIndex = 0;
  String currentName = "";
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double value = 0;

  _AssessmentScreenState();
  void initState() {
    context.read<AssessmentBloc>().add(FetchAssessment());
    _accessCodeBloc = context.read<AccessCodeBloc>();
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
          'Assessment',
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
      body: BlocListener<AccessCodeBloc, AccessCodeState>(
        listener: (context, state) {
          if (state is AccessCodeSendingState){
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                elevation: 6.0,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                backgroundColor: Color(0xFF5d74e3),
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Verifying Access Code ...'),
                      CircularProgressIndicator()
                    ])));
          }

          if (state is AccessCodeLoadedState) {
            if(state.verify){
              Navigator.pushNamed(
                context, '/exam',
                arguments: ScreenArguments(currentId, currentName, 'Assessment'),
              );
            }else{
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                      elevation: 6.0,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Access Code Failed!',
                                style: TextStyle(color: Colors.white)),
                            Icon(Icons.error, color: Colors.white)
                          ]),
                      backgroundColor: Colors.red),
                );
            }
          }

          if(state is AccessCodeSendErrorState){
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Verifying Error!',
                            style: TextStyle(color: Colors.white)),
                        Icon(Icons.error, color: Colors.white)
                      ]),
                  backgroundColor: Colors.red),
            );
          }
        },
        child: BlocBuilder<AssessmentBloc, AssessmentState>(
          builder: (context, state) {
            if (state is AssessmentError) {
              return Center(
                child: Text(
                  "Couldn\'t load asssessment!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),                              
                ),
              );
            }

            if (state is AssessmentLoading) {
              return LoadingIndicator(
                size: 50.0,
              );
            }

            if (state is AssessmentLoaded) {
              final assessments = state.tests;
              
              if(assessments.isEmpty){
                return Center(
                  child: Text(
                      "No Assessment yet!",
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
                    SliverList(delegate: SliverChildBuilderDelegate(
                      (context, index) => index >= assessments.length ?
                      LoadingIndicator() :
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
                                    Row(
                                      children :[
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Image.asset('assets/images/test.png'),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 20.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${assessments[index].name.substring(0, (assessments[index].name.length > 13 ? 13 : assessments[index].name.length))}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                  )),
                                              Text(
                                                '${assessments[index].lastTime == null ? '---------------------------------' : assessments[index].lastTime}',
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: 
                                      assessments[index].mark == null ? (
                                        ++rockIndex > 1 ? 
                                          Container(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Image.asset('assets/images/rock.png'),
                                          ),
                                        )
                                        :
                                        TextButton(
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
                                            verifyAccessCode(assessments[index].id, assessments[index].name);
                                          },
                                        )
                                      ):
                                      Text(
                                        '${assessments[index].mark.round()}'+'%',
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
                      childCount: assessments.length,
                    ))
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ));
  }

  void verifyAccessCode(id, name){
    final accessCodeController = TextEditingController();

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
        content: TextField(
          controller: accessCodeController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all( Radius.circular(4)),
              borderSide: BorderSide( width: 1, color: Color(0xFF2F449B)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1, color: Color(0xFF2F449B)),
            ),
            labelText: 'Code',
            labelStyle: TextStyle(color: Color(0xFF2F449B)),
            hintText: 'Enter Access Code',
            hintStyle: TextStyle(color: Color(0xFF2F449B)),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              currentId = id,
              currentName = name,
              Navigator.pop(context, 'Cancel'),              
              _accessCodeBloc.add(SendAccessCodeEvent(assessmentId: id, accessCode: accessCodeController.text)),
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

  }


}
