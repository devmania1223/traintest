import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/contact/contact_bloc.dart';
import 'package:educa_feedback/screens/contact/contact_screen.dart';

class ContactWrapper extends StatelessWidget {
  const ContactWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: context.watch<ContactBloc>(),
      child: ContactScreen(),
    );
  }
}
