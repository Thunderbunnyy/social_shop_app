import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:social_shop_app/components/background_painter.dart';
import 'package:social_shop_app/screens/auth/sign_in.dart';
import 'package:social_shop_app/screens/auth/sign_up.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller.view,
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: ValueListenableBuilder<bool>(
                valueListenable: showSignInPage,
                builder: (context, value, child) {
                  return PageTransitionSwitcher(
                      reverse: !value,
                      duration: Duration(milliseconds: 800),
                      transitionBuilder: (Widget child,
                          Animation<double> primaryAnimation,
                          Animation<double> secondaryAnimation) {
                        return SharedAxisTransition(
                            animation: primaryAnimation,
                            secondaryAnimation: secondaryAnimation,
                            fillColor: Colors.transparent,
                            child: child,
                            transitionType: SharedAxisTransitionType.vertical);
                      },
                      child: value
                          ? SignIn(
                              onRegisterClicked: () {
                                showSignInPage.value = false;
                                _controller.forward();
                              },
                            )
                          : SignUp(
                              onSignInClicked: () {
                                showSignInPage.value = true;
                                _controller.reverse();
                              },
                            ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
