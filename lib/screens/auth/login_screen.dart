import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/auth/authentication/authentication_bloc.dart';
import 'package:educa_feedback/blocs/auth/login/login_bloc.dart';
// import 'package:educa_feedback/widgets/wave.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool isForgotPasswordEnabled(LoginState state) {
    return state.isEmailValid && _emailController.text.isNotEmpty;
  }

  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _toggleVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state.isFailure) {
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
                          Text('Invalid Credentials!',
                              style: TextStyle(color: Colors.white)),
                          Icon(Icons.error, color: Colors.white)
                        ]),
                    backgroundColor: Colors.red),
              );
          }
          if (state.isPasswordResetFailure) {
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
                            'error',
                          ),
                          Icon(Icons.error)
                        ]),
                    backgroundColor: Colors.white),
              );
          }
          if (state.isPasswordResetMailSent) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Password reset mail has been sent to your email address'),
                      Icon(Icons.check)
                    ],
                  ),
                  backgroundColor: Colors.white));
          }
          if (state.isSubmitting) {
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
                        Text('Logging in...'),
                        CircularProgressIndicator()
                      ])));
          }
          if (state.isSuccess) {
            context.read<AuthenticationBloc>().add(AuthenticationLoggedIn());
          }
        }, child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: SizedBox(
                          width: 300,
                          height: 150,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .cursorColor,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        filled: true,
                                        focusColor:
                                            Theme.of(context).primaryColor,
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        prefixIcon: Icon(Icons.mail,
                                            color: Colors.white),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        errorStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      controller: _emailController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      autocorrect: false,
                                      validator: (_) {
                                        if (!state.isEmailValid) {
                                          return ('Invalid Email');
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 30.0),
                                    TextFormField(
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .cursorColor,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        filled: true,
                                        focusColor:
                                            Theme.of(context).primaryColor,
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        prefixIcon: Icon(Icons.lock_outline,
                                            color: Colors.white),
                                        suffixIcon: IconButton(
                                            icon: _isPasswordHidden
                                                ? Icon(Icons.visibility_off,
                                                    color: Colors.white)
                                                : Icon(Icons.visibility,
                                                    color: Colors.white),
                                            onPressed: () {
                                              _toggleVisibility();
                                            }),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        errorStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      obscureText: _isPasswordHidden,
                                      controller: _passwordController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      autocorrect: false,
                                      validator: (_) {
                                        if (!state.isPasswordValid) {
                                          return ('Invalid Password');
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 50.0),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: isLoginButtonEnabled(state)
                                        ? _onFormSubmitted
                                        : null,
                                    child: SizedBox(
                                      height: 50.0,
                                      width: size.width,
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 18.0,
                                              letterSpacing: 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/forgot-password');
                                  },
                                  child: Text('Forgot your password?',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                              SizedBox(height: 100.0),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
