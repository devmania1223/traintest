import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;
  String route;
  NavigationModel({this.title, this.icon, this.route});
}

List<NavigationModel> navItems = [
  NavigationModel(
    title: 'Profile',
    icon: Icons.person,
    route: 'profile',
  ),
  // NavigationModel(
  //   title: 'Calendar',
  //   icon: Icons.calendar_today,
  //   route: 'calendar',
  // ),
  NavigationModel(
    title: 'Grades',
    icon: Icons.school,
    route: 'grades',
  ),
  NavigationModel(
    title: 'Contact',
    icon: Icons.contact_mail,
    route: 'contact',
  ),
];

final TextStyle navItemStyle =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black);

final TextStyle navItemSelectedStyle =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black);
