import 'package:flutter/material.dart';
import 'package:educa_feedback/models/problem.dart';

class ProblemCard extends StatefulWidget {
  final int index;
  final Problem problem;

  const ProblemCard({Key key, @required this.index, @required this.problem})
      : super(key: key);

  @override
  _ProblemCardState createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard> {
  
  int _value = -1;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      // decoration: BoxDecoration(
      //   color: Theme.of(context).cardColor,
      //   borderRadius: BorderRadius.circular(20.0),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Theme.of(context).canvasColor,
      //       offset: Offset(10, 10),
      //       blurRadius: 10.0,
      //     ),
      //   ],
      // ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${widget.index + 1}" + ". ${widget.problem.content}",
              style: TextStyle(
                  color: Color(0xFFBA509D), fontSize: 18.0),
            ),
            RadioListTile(
              title: Text('${widget.problem.choose1}'),
              value: 1,
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              activeColor: const Color(0xFF2F449B),
            ),
            RadioListTile(
              title: Text('${widget.problem.choose2}'),
              value: 2,
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              activeColor: const Color(0xFF2F449B),
            ),
            RadioListTile(
              title: Text('${widget.problem.choose3}'),
              value: 3,
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              activeColor: const Color(0xFF2F449B),
            ),
            RadioListTile(
              title: Text('${widget.problem.choose4}'),
              value: 4,
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              activeColor: const Color(0xFF2F449B),
            ),
            
        ],
      ),
    );
  }

}
