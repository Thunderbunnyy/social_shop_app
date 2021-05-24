
import 'package:parse_server_sdk/parse_server_sdk.dart';

class DatabaseService {
  // Future initialize() async {
  //   await Parse().initialize(AppKeyName, keyParseServerUrl);
  // }

  //final GoogleSignIn _googleSignIn = GoogleSignIn( scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'] );

  // Future<void> createItem() async {
  //   final ParseObject newObject = ParseObject('Product');
  //   newObject.set<String>('title', 'Product loul');
  //   newObject.set<int>('price', 200);
  //
  //   final ParseResponse apiResponse = await newObject.create();
  //
  //   print(apiResponse);
  //
  //   if (apiResponse.success && apiResponse.count > 0) {
  //     print(AppKeyName + ': ' + apiResponse.result.toString());
  //   }
  // }
  //
  // Future<List<ParseObject>> getCategoriesList() async {
  //
  //   final apiResponse = await ParseObject('Category').getAll();
  //
  //   print(apiResponse.success.toString());
  //   print(apiResponse.error.toString());
  //   print(apiResponse.results.toString());
  //
  //   //List<Category> categories;
  //
  //   if (apiResponse.success && apiResponse.results != null) {
  //     return apiResponse.results;
  //   } else {
  //     return [];
  //   }
  // }
  //
  // Future<List<ParseObject>> getSubCategoriesList(String id) async {
  //   print('stupid text');
  //
  //   QueryBuilder<ParseObject> subcategoriesQuery =
  //       QueryBuilder<ParseObject>(ParseObject('SubCategory'))
  //         ..whereEqualTo('categoryId', id);
  //
  //   final ParseResponse apiResponse = await subcategoriesQuery.query();
  //
  //   if (apiResponse.success && apiResponse.results != null) {
  //     return apiResponse.results;
  //   } else {
  //     return [];
  //   }
  // }

  // void doUserRegistration(
  //     String username, String email, String password) async {
  //   final user = ParseUser.createUser(username, password, email);
  //
  //   var response = await user.signUp();
  //
  //   if (response.success) {
  //     print('success');
  //   } else {
  //     print(response.error.message);
  //   }
  // }
  //
  // void doUserLogin(String email, String password, bool isLoggedIn) async {
  //   final user = ParseUser(email, password, null);
  //
  //   var response = await user.login();
  //
  //   if (response.success) {
  //     print('sahit');
  //     isLoggedIn = true;
  //   } else {
  //     print(response.error.message);
  //   }
  // }

  void doUserLogout(bool isLoggedIn) async {
    final user = await ParseUser.currentUser();
    var response = await user.logout();
    if (response.success) {
      print("User was successfully logout!");
      isLoggedIn = false;
    } else {
      print(response.error.message);
    }
  }

  // Future<void> goToFacebookLogin() async {
  //   final FacebookLogin facebookLogin = new FacebookLogin();
  //   final FacebookLoginResult result = await facebookLogin.logIn(['email']);
  //
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final ParseResponse response = await ParseUser.loginWith(
  //           'facebook',
  //           facebook(result.accessToken.token,
  //               result.accessToken.userId,
  //               result.accessToken.expires));
  //
  //       if (response.success) {
  //         // User is logged in, test with ParseUser.currentUser()
  //
  //         print(ParseUser.currentUser());
  //       }
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //     // User cancelled
  //       break;
  //     case FacebookLoginStatus.error:
  //     // Error
  //       break;
  //   }
  // }
  //
  // signInGoogle() async {
  //
  //   GoogleSignInAccount account = await _googleSignIn.signIn();
  //
  //   GoogleSignInAuthentication authentication = await account.authentication;
  //
  //   await ParseUser.loginWith(
  //       'google',
  //       google(authentication.accessToken, _googleSignIn.currentUser.id,
  //           authentication.idToken));
  //   print(ParseUser.currentUser());
  //
  // }

}
