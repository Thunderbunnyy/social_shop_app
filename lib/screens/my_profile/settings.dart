import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:social_shop_app/config/palette.dart';

class Settings extends StatefulWidget {

  final String userId;

  const Settings({Key key, this.userId}) : super(key: key);
  
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: TextStyle(
          color: Colors.black54
        ),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: SettingsList(
        backgroundColor: Colors.white,
        sections: [
          SettingsSection(
            title: 'Account',
            titleTextStyle: TextStyle(
            color: Palette.lavender,fontSize: 18.0,fontWeight: FontWeight.bold
            ),
            tiles: [
              SettingsTile(
                  title: 'Edit Profile',
                 leading: Icon(Icons.edit,color: Palette.lavender),
                 onPressed: (BuildContext context){

                 },
              ),
              SettingsTile(
                title: 'My orders',
                leading: Icon(Icons.shopping_cart_rounded,color: Palette.lavender),
                onPressed: (BuildContext context){

                },
              ),
              SettingsTile(
                title: 'Liked Products',
                leading: Icon(Icons.favorite_outlined,color: Palette.lavender),
                onPressed: (BuildContext context){

                },
              ),
              SettingsTile(
                title: 'Payment Settings',
                leading: Icon(Icons.credit_card_outlined,color: Palette.lavender),
                onPressed: (BuildContext context){

                },
              ),
              SettingsTile(
                title: 'My Address',
                leading: Icon(Icons.location_on,color: Palette.lavender),
                onPressed: (BuildContext context){

                },
              ),
            ],
          ),
          SettingsSection(
            title: 'App Settings',
            titleTextStyle: TextStyle(
                color: Palette.lavender,fontSize: 18.0,fontWeight: FontWeight.bold
            ),
            tiles: [
              SettingsTile(
                title: 'Notifications',
                leading: Icon(Icons.notifications,color: Palette.lavender),
                onPressed: (BuildContext context){

                },
              ),
              SettingsTile.switchTile(
                title: 'Dark Mode',
                leading: Icon(FontAwesome.moon_o,color: Palette.lavender),
                switchValue: value,
                onToggle: (bool value) {

                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
