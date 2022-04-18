import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/auth_profile/auth_profile_bloc.dart';
import 'package:educa_feedback/models/navigation.dart';
import 'package:educa_feedback/preferences/preferences.dart';
import 'package:educa_feedback/widgets/loading_indicator.dart';
import 'package:educa_feedback/widgets/dialogs/logout_dialog.dart';
import 'package:educa_feedback/widgets/nav/nav_item.dart';

import 'package:educa_feedback/constants/constants.dart';

class NavDrawer extends StatefulWidget {
  final String currentRoute;
  const NavDrawer(this.currentRoute);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  int currentSelectedIndex = -1;
  @override
  void initState() {
    super.initState();
    context.read<AuthProfileBloc>().add(
          FetchAuthProfile(),
        );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Drawer(
      child: Container(
        color: Theme.of(context).cardColor,
        child: Column(
          children: <Widget>[
            BlocBuilder<AuthProfileBloc, AuthProfileState>(
                builder: (context, state) {
              if (state is AuthProfileLoaded) {
                return new Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.3,
                        child: UserAccountsDrawerHeader(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFBA509D), Color(0xFF39459B)]),
                          ),
                          accountName: Text(
                            state.user.name,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          accountEmail: const Text("Beginner"),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                Constants.WEBSITE_URL + state.user.photo),
                            radius: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFBA509D), Color(0xFF39459B)]),
                ),
                child: LoadingIndicator(size: 30.0),
              );
            }),
            Expanded(
              flex: 10,
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return SizedBox(height: 0.3);
                },
                itemBuilder: (context, counter) {
                  return navigationItem(
                    context,
                    onTap: () async {
                      setState(() {
                        currentSelectedIndex = counter;
                      });
                      if (navItems[counter].title == 'Profile') {
                        Navigator.pushNamed(
                          context,
                          '/${navItems[counter].route}',
                          arguments: Prefer.prefs.getString('email'),
                        );
                      } else
                        Navigator.pushNamed(
                            context, '/${navItems[counter].route}');
                    },
                    boxColor: Colors.white,
                    title: navItems[counter].title,
                    icon: navItems[counter].icon,
                    iconColor: Theme.of(context).hintColor,
                    textStyle: navItemStyle,
                  );
                },
                itemCount: navItems.length,
              ),
            ),
            Column(
              children: <Widget>[
                navigationItem(
                  context,
                  title: 'Log out',
                  icon: Icons.exit_to_app,
                  boxColor: Theme.of(context).hintColor.withOpacity(.05),
                  iconColor: Theme.of(context).hintColor,
                  textStyle: navItemStyle,
                  onTap: () {
                    logoutDialog(context, null);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
