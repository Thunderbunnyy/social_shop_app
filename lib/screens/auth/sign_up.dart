import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter/material.dart';
import 'package:social_shop_app/config/constants.dart';
import 'package:social_shop_app/config/palette.dart';
import 'package:social_shop_app/data/models/user.dart';
import 'package:social_shop_app/data/repositories/Users/provider_api_user.dart';
import 'package:social_shop_app/screens/auth/sign_bar.dart';

class SignUp extends StatefulWidget {

  final VoidCallback onSignInClicked;

  const SignUp({Key key, this.onSignInClicked}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();

  bool _isLoading;
  String _errorMessage;

  ParseFileBase parseFile;

  // var list = [
  //   "assets/images/avatar1.png",
  //   "assets/images/avatar2.png",
  //   "assets/images/avatar3.png",
  //   "assets/images/avatar4.png",
  //   "assets/images/avatar5.png",
  //   "assets/images/avatar6.png"
  // ] ;

  final usernameController= new TextEditingController();
  final emailController= new TextEditingController();
  final passwordController= new TextEditingController();
  final fullNameController= new TextEditingController();

  bool _validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _validateAndSubmit() async {
    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });
    if (_validateAndSave()) {

     //  final _random = new Random();
     //  String element = list[_random.nextInt(list.length)];
     //
     // // var bytes = (await rootBundle.load(element)).buffer.asUint8List();
     //  ByteData bytes = await rootBundle.load(element);

      final username = usernameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final fullName = fullNameController.text.trim();

      // if (kIsWeb) {
      //   ParseWebFile file = ParseWebFile(null, name: null, url : element);
      //   await file.download();
      //   parseFile = ParseWebFile(file.file, name: file.name);
      // } else {
      //   parseFile = ParseFile(File.fromRawPath(bytes.buffer.));
      // }

      final User user = User(username,password,email);
      //UserProviderApi().createUser(username,password,email);

      user.set(User.keyFullName, fullName);
      //user.set(User.keyDisplayPicture, parseFile);

      ParseResponse response;
      try {
        response = await user.signUp();
          print('Signed up user:');

        setState(() {
          _isLoading = false;
        });
        if (response.success) {
          user.save();
          print('sahit');
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = response.error.toString();
          });
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = '';
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        padding: EdgeInsets.only(top: size.height / 9.5, right: size.width / 4),
        child: Text('Register',
            style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              size.width / 9.5, size.height / 9.5, size.width / 9.5, 0.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: fullNameController,
                    maxLines: 1,
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: 'FULL NAME',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kTertiaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: usernameController,
                    maxLines: 1,
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: 'USERNAME',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kTertiaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: emailController,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kTertiaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: passwordController,
                    maxLines: 1,
                    obscureText: true,
                    autofocus: false,
                    validator: (val) => val.length < 6 || val.isEmpty
                        ? 'Enter a password 6+ chars long'
                        : null,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kTertiaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    validator: (val) => val != passwordController.text?
                         'Password does not match'
                        : null,
                    decoration: InputDecoration(
                        labelText: 'CONFIRM PASSWORD',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kTertiaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    obscureText: true,
                  ),
                  // Row(
                  //   children: [
                  //     Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Text(
                  //         'Choose an avatar picture :',
                  //         style: TextStyle(
                  //             fontSize: 20, color: Colors.black87),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () async {
                  //         PickedFile pickedFile = await ImagePicker()
                  //             .getImage(source: ImageSource.gallery);
                  //
                  //         if (kIsWeb) {
                  //           ParseWebFile file = ParseWebFile(null,
                  //               name: null, url: pickedFile.path);
                  //           await file.download();
                  //           parseFile = ParseWebFile(file.file,
                  //               name: file.name);
                  //         } else {
                  //           parseFile = ParseFile(File(pickedFile.path));
                  //         }
                  //
                  //
                  //
                  //       },
                  //       child: Container(
                  //         child: Container(
                  //
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  SignUpBar(
                    label: 'Sign Up',
                    isLoading: _isLoading,
                    onPressed: () {
                      // final username = usernameController.text.trim();
                      // final email = emailController.text.trim();
                      // final password = passwordController.text.trim();
                      // DatabaseService()
                      //     .doUserRegistration(username, email, password);

                        _validateAndSubmit();

                    },
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          widget.onSignInClicked?.call();
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Palette.coral,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
