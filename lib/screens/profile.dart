import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/data/models/user.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: TextButton(onPressed: () async {
        final User currentUser = await ParseUser.currentUser(customUserObject: User.clone());
        currentUser.logout(deleteLocalUserData: true);
        Navigator.pop(context, true);
      }, child: Text('logout'),

      ),
    );
  }
}
