import 'package:flutter/material.dart';

Widget navigationItem(context,
    {Color boxColor,
    String title,
    TextStyle textStyle,
    IconData icon,
    Color iconColor,
    VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 10.0, bottom: 10.0, right: 8.0),
        child: Row(
          children: <Widget>[
            Icon(icon, color: iconColor, size: 23.0),
            SizedBox(width: 30.0),
            Text(
              title,
              style: textStyle,
            )
          ],
        ),
      ),
    ),
  );
}
