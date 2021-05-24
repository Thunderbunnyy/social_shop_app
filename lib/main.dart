import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_shop_app/Providers/options_providers.dart';
import 'package:social_shop_app/screens/decision_page.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();

  // final keyApplicationId = AppKeyName;
  // final keyParseServerUrl = "http://10.0.2.2:1337/parse";
  //
  // await Parse().initialize(keyApplicationId, keyParseServerUrl, debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OptionsProvider>(
      create: (context) => OptionsProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DecisionPage(),
          theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.montserratTextTheme(Theme
                  .of(context)
                  .textTheme),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          fontFamily: 'Montserrat'
                      )
                  )
              )

          )
      ),

    );
  }


}
