import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:educa_feedback/blocs/auth_profile/auth_profile_bloc.dart';
import 'package:educa_feedback/blocs/profile/profile/profile_bloc.dart';
import 'package:educa_feedback/widgets/loading_indicator.dart';
import 'package:educa_feedback/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  ProfileScreen({Key key, @required this.email}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled(AuthProfileState state) {
    return _formKey.currentState.validate() &&
        state is! AuthProfileInfoUpdating;
  }

  void initState() {
    context.read<ProfileBloc>().add(FetchProfile(email: widget.email));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _autovalidate = false;
  File _photo;
  String _email;

  Future _getImage(ImageSource source, bool isPhoto) async {
    final picker = ImagePicker();

    setState(() {});
    final pickedFile = await picker.getImage(source: source);

    File image = File(pickedFile.path);

    if (image != null) {
      // File croppedImage = await ImageCropper.cropImage(
      //   sourcePath: image.path,
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   compressQuality: 100,
      //   compressFormat: ImageCompressFormat.png,
      //   androidUiSettings: AndroidUiSettings(
      //     toolbarTitle: 'Edit Photo',
      //     toolbarColor: Theme.of(context).cardColor,
      //     activeControlsWidgetColor: Colors.blue,
      //   ),
      // );

      // setState(() {
      //   _photo = croppedImage;
      // });
    } else {
      setState(() {});
    }
  }

  Future<bool> selectImageDialog(context, {bool isPhoto = true}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 230.0,
            width: 200.0,
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Choose an option',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 20.0),
                  ),
                ),
                SizedBox(height: 30.0),
                InkWell(
                  onTap: () {
                    _getImage(ImageSource.camera, isPhoto);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        SizedBox(width: 20.0),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                InkWell(
                  onTap: () {
                    _getImage(ImageSource.gallery, isPhoto);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        SizedBox(width: 20.0),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
              'Edit Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextButton(
                  // onPressed: isButtonEnabled() ? _onFormSubmitted : null,
                  onPressed: _onFormSubmitted,
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    onSurface: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ],
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            )),
        body: BlocListener<AuthProfileBloc, AuthProfileState>(
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
                    backgroundColor: Colors.red,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.errorMessage,
                        ),
                      ],
                    ),
                  ),
                );
            }
            if (state is AuthProfileInfoUpdating) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    elevation: 6.0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: Theme.of(context).primaryColorDark,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Saving...',
                        ),
                        CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                );
            }
            if (state is AuthProfileInfoUpdateSuccess) {
              context.read<ProfileBloc>().add(RefreshProfile(user: state.user));
              context
                  .read<AuthProfileBloc>()
                  .add(ReloadAuthProfile(user: state.user));

              // Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileError) {
                return Center(
                  child: Text(
                    'Couldn\'t load prodfile.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              }
              if (state is ProfileLoading) {
                return LoadingIndicator(
                  size: 50.0,
                );
              }
              if (state is ProfileLoaded) {
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 30.0),
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () =>
                                      selectImageDialog(context, isPhoto: true),
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor:
                                        Theme.of(context).cardColor,
                                    backgroundImage: _photo == null
                                        ? NetworkImage(Constants.WEBSITE_URL +
                                            state.user.photo)
                                        : FileImage(_photo),
                                  ),
                                ),
                              ),
                            ),
                            //===> Name Text Input starts from here <===
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0,
                                  bottom: 10.0,
                                  left: 1.0,
                                  right: 1.0),
                              child: TextFormField(
                                initialValue: state.user.name,
                                readOnly: true,
                                autofocus: false,
                                keyboardType: TextInputType.name,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: 'Name',
                                ),
                              ),
                            ),

                            //===> Email Address Text Input starts from here <===
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 1.0,
                                  bottom: 10.0,
                                  left: 1.0,
                                  right: 1.0),
                              child: TextFormField(
                                initialValue: state.user.email,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: 'Email',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                onSaved: (value) => _email = value,
                              ),
                            ),

                            //===> Student ID Input starts from here <===
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 1.0,
                                  bottom: 10.0,
                                  left: 1.0,
                                  right: 1.0),
                              child: TextFormField(
                                initialValue: state.user.id.toString(),
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: 'Student ID',
                                ),
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 5.0,
                                  left: 1.0,
                                  right: 1.0),
                              // child: Text(
                              //   "Achivements",
                              //   style: TextStyle(
                              //       color: Color(0xFFBA509D), fontSize: 20),
                              // ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 1.0,
                                  right: 1.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 5.0,
                                    //       bottom: 5.0,
                                    //       left: 1.0,
                                    //       right: 1.0),
                                    //   child: Container(
                                    //     decoration: new BoxDecoration(
                                    //       color: Color(0xFF2F449B),
                                    //       borderRadius:
                                    //           BorderRadius.circular(6),
                                    //     ),
                                    //     child: ListTile(
                                    //       leading: SizedBox(
                                    //         width: 50,
                                    //         height: 50,
                                    //         child: Image.asset(
                                    //             'assets/images/star.png'),
                                    //       ),
                                    //       title: const Text('Complete 10',
                                    //           style: TextStyle(
                                    //             color: Colors.white,
                                    //             fontSize: 20,
                                    //             fontWeight: FontWeight.w900,
                                    //           )),
                                    //       subtitle: const Text(
                                    //         'Practice Exerciese',
                                    //         style: TextStyle(
                                    //             color: Colors.white,
                                    //             fontSize: 18),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 5.0,
                                    //       bottom: 5.0,
                                    //       left: 1.0,
                                    //       right: 1.0),
                                    //   child: Container(
                                    //     decoration: new BoxDecoration(
                                    //       color: Color(0xFF2F449B),
                                    //       borderRadius:
                                    //           BorderRadius.circular(6),
                                    //     ),
                                    //     child: ListTile(
                                    //       leading: SizedBox(
                                    //         width: 50,
                                    //         height: 50,
                                    //         child: Image.asset(
                                    //             'assets/images/star.png'),
                                    //       ),
                                    //       title: const Text('Complete 10',
                                    //           style: TextStyle(
                                    //             color: Colors.white,
                                    //             fontSize: 20,
                                    //             fontWeight: FontWeight.w900,
                                    //           )),
                                    //       subtitle: const Text(
                                    //         'Practice Exerciese',
                                    //         style: TextStyle(
                                    //             color: Colors.white,
                                    //             fontSize: 18),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container();
            },
          ),
        ));
  }

  void _onFormSubmitted() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      context.read<AuthProfileBloc>().add(
            UpdateAuthProfileInfo(
              email: _email,
              photo: _photo,
            ),
          );
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
