import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:social_shop_app/config/constants.dart';
import 'package:social_shop_app/data/models/user.dart';
import 'package:social_shop_app/data/repositories/Users/user_repository.dart';
import 'package:social_shop_app/screens/auth/sign_bar.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onRegisterClicked;

  const SignIn({Key key, this.onRegisterClicked}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String _errorMessage;

  @override
  void initState() {
    _errorMessage = '';
    _isLoading = false;
    UserRepository();
    super.initState();
  }

  final emailController= new TextEditingController();
  final passwordController= new TextEditingController();
  final usernameController= new TextEditingController();


  bool _validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    _isLoading= false;
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

      try {

        var response = await user.login();
        //UserRepository().save(user);

        if (response.success ) {
          user.save();
          // final User currentUser = await ParseUser.currentUser(customUserObject: User.clone());
          // print(currentUser);
          // final ParseResponse parseResponse = await ParseUser.getCurrentUserFromServer(currentUser.sessionToken);
          // print(parseResponse);

          print('sahit');
          Navigator.pop(context,true);
        } else {
          setState(() {
             print('lé');
            _isLoading = false;
            _errorMessage = response.error.toString();
          });
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          //_errorMessage = e.message;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        padding: EdgeInsets.only(top: size.height / 9, right: size.width / 5),
        child: Text('Hello Again',
            style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              size.width / 9.5, size.height / 6.5, size.width / 9.5, 0.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    maxLines: 1,
                    autofocus: false,
                    validator: (val) {
                      return val.isEmpty ? 'Enter your username' : null;
                    },
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
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      return val.isEmpty ? 'Enter an email' : null;
                    },
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
                    autofocus: false,
                    validator: (val) => val.length < 6
                        ? 'Enter a password '
                        : null,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kTertiaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    obscureText: true,
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: kTertiaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  SignInBar(
                    label: 'Sign in',
                    isLoading: _isLoading,
                    onPressed: () {

                      //DatabaseService().doUserLogin(emailController.text.trim(), passwordController.text.trim(), isLoggedIn);

                      _validateAndSubmit();
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SignInButton(
                        buttonType: ButtonType.mail,
                        imagePosition: ImagePosition.right,
                        buttonSize: ButtonSize.medium,
                        btnTextColor: Colors.grey,
                        btnColor: Colors.white,
                        btnText: 'Email Sign Up',
                        elevation: 0.3,
                        onPressed: () {
                          widget.onRegisterClicked?.call();
                        }),
                  ),

                  SignInButton(
                      buttonType: ButtonType.google,
                      imagePosition: ImagePosition.right,
                      buttonSize: ButtonSize.medium,
                      btnTextColor: Colors.grey,
                      btnColor: Colors.white,
                      btnText: 'Google Sign In',
                      elevation: 0.3,
                      onPressed: () {
                        //DatabaseService().signInGoogle();
                      }),

                  SignInButton(
                      buttonType: ButtonType.facebook,
                      imagePosition: ImagePosition.right,
                      buttonSize: ButtonSize.medium,
                      btnTextColor: Colors.grey,
                      btnColor: Colors.white,
                      elevation: 0.3,
                      btnText: 'Facebook Sign In',
                      onPressed: () {
                        //DatabaseService().goToFacebookLogin();
                      })

                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
