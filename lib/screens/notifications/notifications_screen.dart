import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   context.read<NotificationsBloc>().add(
  //         FetchNotifications(),
  //       );
  // }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Notifications',
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
          // child: Center(
          //   child: BlocBuilder<NotificationsBloc, NotificationsState>(
          //       builder: (context, state) {
          //     if (state is NotificationsLoaded) {
          //       return Container(
          //         child: ListView(
          //           shrinkWrap: true,
          //           padding: const EdgeInsets.only(
          //             left: 30.0,
          //             right: 30.0,
          //             top: 50.0,
          //           ),
          //           children: <Widget>[
          //             GestureDetector(
          //               onTap: () {},
          //               child: Container(
          //                 padding: const EdgeInsets.only(
          //                     top: 10.0, bottom: 10.0, left: .0, right: 1.0),
          //                 child: Column(
          //                   children: [
          //                     Container(
          //                       padding: const EdgeInsets.only(
          //                           top: 20.0,
          //                           bottom: 20.0,
          //                           left: 20.0,
          //                           right: 15.0),
          //                       decoration: new BoxDecoration(
          //                         color: Color(0xFF2F449B),
          //                         borderRadius: BorderRadius.circular(20),
          //                       ),
          //                       child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               SizedBox(
          //                                 width: 40,
          //                                 height: 40,
          //                                 child: Image.asset(
          //                                     'assets/images/alarm.png'),
          //                               ),
          //                               Container(
          //                                 padding:
          //                                     const EdgeInsets.only(left: 10.0),
          //                                 child: Column(
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.start,
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                   children: const [
          //                                     Text('notice1',
          //                                         style: TextStyle(
          //                                           color: Colors.white,
          //                                           fontSize: 20,
          //                                           fontWeight: FontWeight.w900,
          //                                         )),
          //                                     SizedBox(
          //                                       width: 180,
          //                                       child: Text(
          //                                         'hello, every one .Iam director!',
          //                                         style: TextStyle(
          //                                           color: Colors.white,
          //                                           fontSize: 18,
          //                                           fontWeight: FontWeight.w500,
          //                                         ),
          //                                       ),
          //                                     )
          //                                   ],
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           Container(
          //                             alignment: Alignment.centerRight,
          //                             padding: const EdgeInsets.only(left: 10.0),
          //                             child: Icon(
          //                               Icons.looks_rounded,
          //                               size: 34,
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     }
          //   }),
          // ),
          ),
    );
  }
}
