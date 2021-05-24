import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter/material.dart';
import 'package:social_shop_app/config/constants.dart';
import 'package:social_shop_app/config/palette.dart';
import 'package:social_shop_app/data/models/user.dart';
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


  final usernameController= new TextEditingController();
  final emailController= new TextEditingController();
  final passwordController= new TextEditingController();

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

      final username = usernameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final User user = User(username,password,email);

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
        padding: EdgeInsets.only(top: size.height / 9, right: size.width / 4),
        child: Text('Register',
            style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              size.width / 9.5, size.height / 6, size.width / 9.5, 0.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                  SizedBox(height: 5.0),
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
