import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/auth_profile/auth_profile_bloc.dart';
import 'package:educa_feedback/utils/validators.dart';
import 'package:educa_feedback/widgets/loading_indicator.dart';

class ForgotCodeScreen extends StatefulWidget {
  ForgotCodeScreen({Key key}) : super(key: key);

  @override
  _ForgotCodeScreenState createState() => _ForgotCodeScreenState();
}

class _ForgotCodeScreenState extends State<ForgotCodeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  bool isButtonEnabled(AuthProfileState state) {
    return !(state is ResetCodeRequestLoading);
  }

  String _code;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorDark,
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: BlocListener<AuthProfileBloc, AuthProfileState>(
              listener: (context, state) {
                if (state is AuthProfileErrorMessage) {
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
                              Text(
                                state.errorMessage,
                              ),
                              Icon(Icons.error, color: Colors.white)
                            ],
                          ),
                          backgroundColor: Colors.red),
                    );
                }
                if (state is ResetCodeRequestSuccess) {
                  Navigator.pushNamed(context, '/');
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        elevation: 6.0,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.blue,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Please check your email!'),
                          ],
                        ),
                      ),
                    );
                  _formKey.currentState.reset();
                  setState(() {
                    _autovalidate = false;
                  });
                }
              },
              child: BlocBuilder<AuthProfileBloc, AuthProfileState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: size.width * .08,
                        top: size.height * .02,
                        right: size.width * .08),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autovalidate
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 150.0),
                            child: SizedBox(
                              width: 300,
                              height: 150,
                              child: Image.asset('assets/images/logo.png'),
                            ),
                          ),
                          Text(
                            'Enter 6 Digits Code',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .cursorColor,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              filled: true,
                              focusColor: Theme.of(context).primaryColor,
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.white),
                              hintText: '6 digits',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            validator: (val) {
                              return !Validators.is6DigitsCode(val)
                                  ? 'Invalid Code.'
                                  : null;
                            },
                            onSaved: (value) => _code = value,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            "We'll send new password to your email.",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 30.0),
                          InkWell(
                            onTap: isButtonEnabled(state)
                                ? _onFormSubmitted
                                : null,
                            child: Container(
                              width: size.width,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  (state is ResetCodeRequestLoading)
                                      ? LoadingIndicator(
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : Text(
                                          'Send Code',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 18.0,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmitted() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      context.read<AuthProfileBloc>().add(
            RequestCodeResetInfo(code: _code),
          );
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
