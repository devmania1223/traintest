import 'package:flutter/material.dart';
import 'package:educa_feedback/models/screen_arguments.dart';
import 'package:educa_feedback/models/topic.dart';

class ProgressAccordion extends StatefulWidget {

  final Topic topic;

  ProgressAccordion(this.topic);
  @override
  _ProgressAccordionState createState() => _ProgressAccordionState();
}

class _ProgressAccordionState extends State<ProgressAccordion> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Container(
      decoration: BoxDecoration(
        color: 
        (widget.topic.mark == null ? Color(0xFFBA509D) : 
        (widget.topic.mark.round() > 70 ? Color(0xFF2F449B) : Color(0xFFBA509D)))),
      child: Column(children: [
        InkWell(
          onTap: () => {
            setState(() {
              _showContent = !_showContent;
            }),
          },
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: Icon(_showContent
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                    onPressed: () {
                      setState(() {
                        _showContent = !_showContent;
                      });
                    },
                  ),
                  Text(
                    '${widget.topic.name.substring(0, (widget.topic.name.length > 20 ? 20 : widget.topic.name.length))}',
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  "${widget.topic.mark == null ? 0 : widget.topic.mark.round()}" + "%",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              )
            ],
          ),
          
        ),
       _showContent
            ? Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Based on your score, you are doing great in this topic. If you want to improve even more your skills, you can try this topic again. Please note that it wont affect your final score, only your learning progress.',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pushNamed(
                              context, '/exam',
                              arguments: ScreenArguments(widget.topic.id, widget.topic.name, 'Progress'),
                            );
                          },
                          child: const Text(
                            "Try Again",
                            style: TextStyle(color: Color(0xFFBA509D)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            : Container()
      ]),
    ));
  }
}
