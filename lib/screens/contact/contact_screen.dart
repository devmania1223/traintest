import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:educa_feedback/blocs/contact/contact_bloc.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ContactBloc _contactBloc;

  bool isButtonEnabled(ContactState state) {
    return _formKey.currentState.validate() && !state.isSubmitting;
  }

  void initState() {
    super.initState();
    // _contactBloc = context.read<ContactBloc>();
    // _emailController.addListener(_onEmailChanged);
  }

  void dispose() {
    // _emailController.dispose();
    super.dispose();
  }

  bool _autovalidate = false;

  // String _name;
  // String _email;
  String _subject;
  String _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            'Contact',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
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
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pushNamed(context, '/');
            },
          )

        ),
        body: BlocListener<ContactBloc, ContactState>(
          listener: (context, state) {
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
                            Text('Submit Error!',
                                style: TextStyle(color: Colors.white)),
                            Icon(Icons.error, color: Colors.white)
                          ]),
                      backgroundColor: Colors.red),
                );
            }
            if (state.isSubmitting) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    elevation: 126.0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: Color(0xFF5d74e3),
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Submmiting...'),
                          CircularProgressIndicator()
                        ])));
            }
            if (state.isSuccess) {
              Navigator.pushNamed(context, '/');
            }
          },
          child:
              BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    autovalidateMode: _autovalidate
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        top: 50.0,
                      ),
                      children: <Widget>[
                        //===> Name Text Input starts from here <===
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       top: 10.0, bottom: 10.0, left: 1.0, right: 1.0),
                        //   child:
                        //   TextFormField(
                        //     autofocus: true,
                        //     keyboardType: TextInputType.text,
                        //     style: TextStyle(fontSize: 16.0, color: Colors.black),
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //       ),
                        //       labelText: 'Name',
                        //       errorBorder: OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.circular(10.0),
                        //         borderSide: BorderSide(
                        //           width: 2.0,
                        //           color: Colors.red,
                        //         ),
                        //       ),
                        //     ),
                        //     validator: (val) {
                        //       return val.trim().isEmpty ? 'Name can not be empty' : null;
                        //     },
                        //     onSaved: (value) => _name = value,
                        //   ),
                        // ),

                        //===> Email Address Text Input starts from here <===
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       top: 1.0, bottom: 10.0, left: 1.0, right: 1.0),
                        //   child: TextFormField(
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //       ),
                        //       errorBorder: OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.circular(10.0),
                        //         borderSide: BorderSide(
                        //           width: 2.0,
                        //           color: Colors.red,
                        //         ),
                        //       ),
                        //       labelText: 'Email',
                        //     ),
                        //     controller: _emailController,
                        //     autovalidateMode: AutovalidateMode.onUserInteraction,
                        //     autocorrect: false,
                        //     validator: (_) {
                        //       if(!state.isEmailValid){
                        //         return ('Invalid Email');
                        //       }
                        //       return null;
                        //     },
                        //     keyboardType: TextInputType.emailAddress,
                        //     style: TextStyle(fontSize: 16.0, color: Colors.black),
                        //   ),
                        // ),

                        Padding(
                          padding: EdgeInsets.only(
                              top: 30.0, bottom: 10.0, left: 1.0, right: 1.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Subject',
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            validator: (val) {
                              return val.trim().isEmpty
                                  ? 'Subject can not be empty'
                                  : null;
                            },
                            onSaved: (value) => _subject = value,
                            keyboardType: TextInputType.text,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),

                        //===> Description Input starts from here <===
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Description',
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          validator: (val) {
                            return val.trim().isEmpty
                                ? 'Description can not be empty'
                                : null;
                          },
                          onSaved: (value) => _description = value,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          maxLines: 15,
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color(0xFF008ECC),
                                offset: Offset(0.0, 0.0),
                                //blurRadius: 20.0,
                              ),
                              BoxShadow(
                                color: Color(0xFF008ECC),
                                offset: Offset(0.0, 0.0),
                                //blurRadius: 20.0,
                              ),
                            ],
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFFBA509D), //Colors is Olympic blue
                                  Color(0xFF39459B),
                                ],
                                begin: FractionalOffset(0.2, 0.2),
                                end: FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: MaterialButton(
                            onPressed: _validateAndSubmit,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }

  // void _onEmailChanged(){
  //   _contactBloc.add(ContactEmailChangedEvent(email: _emailController.text));
  // }

  void _validateAndSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      context.read<ContactBloc>().add(ContactSubmitEvent(
            // name:_name,
            // email:_email,
            subject: _subject,
            description: _description,
          ));
    }
  }
}
