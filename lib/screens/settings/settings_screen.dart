import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/auth_profile/auth_profile_bloc.dart';
import 'package:educa_feedback/screens/settings/account/account_settings_screen.dart';
import 'package:educa_feedback/screens/settings/theme/theme_settings_screen.dart';
import 'package:educa_feedback/widgets/loading_indicator.dart';
import 'package:educa_feedback/widgets/list_tiles/settings_list_tile.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: BackButton(
            color: Theme.of(context).appBarTheme.iconTheme.color,
          ),
          title: Text(
            'Settings',
            // ignore: deprecated_member_use
            style: Theme.of(context).appBarTheme.textTheme.caption,
          ),
          centerTitle: true,
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ),
        body: BlocBuilder<AuthProfileBloc, AuthProfileState>(
          builder: (context, state) {
            if (state is AuthProfileLoading) {
              return LoadingIndicator();
            }
            if (state is AuthProfileLoaded) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                children: <Widget>[
                  Text(
                    '@' + state.user.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 15.0),
                  settingsListTile(context, 'Account', onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            AccountSettingsScreen(user: state.user),
                      ),
                    );
                  }),
                  SizedBox(height: 15.0),
                  settingsListTile(context, 'Theme', onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ThemeSettingsScreen(),
                      ),
                    );
                  })
                ],
              );
            }
            return Container();
          },
        ));
  }
}
