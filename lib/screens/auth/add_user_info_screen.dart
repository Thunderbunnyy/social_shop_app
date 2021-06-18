import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:social_shop_app/config/palette.dart';


class AddInfoScreen extends StatefulWidget {

  @override
  _AddInfoScreenState createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {

  int _currentSelectedIndex;

  final Map<int, String> _avatarIndices = {
    0: 'assets/images/avatar1.png',
    1: 'assets/images/avatar2.png',
    2: 'assets/images/avatar3.png',
    3: 'assets/images/avatar4.png',
    4: 'assets/images/avatar5.png',
    5: 'assets/images/avatar6.jpg',
  };

  Widget _avatar(int index) {
    bool selected = index == _currentSelectedIndex;

    Color borderColor = selected ? Palette.lemon : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _currentSelectedIndex = index;
          });
        },
        child: CircularProfileAvatar(
          '',
          radius: 30.0,
          borderColor: borderColor,
          child: Image.asset(
            _avatarIndices[index],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
