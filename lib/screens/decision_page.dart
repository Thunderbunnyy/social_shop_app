import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_shop_app/components/loader.dart';
import 'package:social_shop_app/config/constants.dart';
import 'package:social_shop_app/data/models/user.dart';
import 'package:social_shop_app/screens/auth/authenticate_screen.dart';
import 'package:social_shop_app/screens/home_screen.dart';


class DecisionPage extends StatefulWidget {
  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  String _parseServerState = 'One sec...';

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initParse();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _showLogo(),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(_parseServerState),
                      ),
                    ],
                  ),
                ),
              )
    );
  }

  Widget _showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: FlipLoader(),
        ),
      ),
    );
  }

  // Future<bool> hasUserLogged() async {
  //
  //   await Parse().initialize(keyApplicationId, keyParseServerUrl,clientKey: keyParseClientKey,debug: true);
  //
  //   //ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
  //   final ParseResponse response = await Parse().healthCheck();
  //   final User currentUser = await ParseUser.currentUser(customUserObject: User.clone());
  //   print(currentUser);
  //   //Checks whether the user's session token is valid
  //   //final ApiResponse apiResponse = await UserProviderApi().getCurrentUserFromServer();
  //
  //   final ParseResponse parseResponse = await ParseUser.getCurrentUserFromServer(currentUser.sessionToken);
  //
  //     if (response.success && parseResponse.success) {
  //
  //       if (currentUser != null) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       setState(() {
  //         _parseServerState =
  //         'Parse Server Not avaiable\n due to ${response.error.toString()}';
  //       });
  //       return false;
  //     }
  //
  // }

  Future<void> _initParse() async {

      try {
        await Parse().initialize(
            keyApplicationId,
            keyParseServerUrl,
            debug: true,
            coreStore: await initCoreStore(),
            autoSendSessionId: true,
        );

        final ParseResponse response = await Parse().healthCheck();
        if (response.success) {
          final User currentUser = await ParseUser.currentUser(customUserObject: User.clone());
          //final ParseUser currentUser = await ParseUser.currentUser();
          //final ParseResponse parseResponse = await ParseUser.getCurrentUserFromServer(currentUser.sessionToken);
          //print(parseResponse);
          print(currentUser);
          if (currentUser != null) {
            _redirectToPage(context, HomePage());
          } else {
            _redirectToPage(context, LoginScreen());
          }
        } else {
          setState(() {
            _parseServerState =
            'Parse Server Not avaiable\n due to ${response.error.toString()}';
          });
        }
      } catch (e) {
        setState(() {
          _parseServerState = e.toString();
        });
      }

  }

  Future<void> _redirectToPage(BuildContext context, Widget page) async {
    final MaterialPageRoute<bool> newRoute =
    MaterialPageRoute<bool>(builder: (BuildContext context) => page);

    final bool nav = await Navigator.of(context)
        .pushAndRemoveUntil<bool>(newRoute, ModalRoute.withName('/'));
    if (nav == true) {
      _initParse();
    }
  }

  Future<CoreStore> initCoreStore() async {
    if (await Permission.storage.request().isGranted)
      return CoreStoreSembastImp.getInstance("/storage/emulated/0/Download/my_db.txt");

  }

}