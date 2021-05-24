import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/user.dart';
import 'package:social_shop_app/data/repositories/Users/contract_provider_user.dart';


class UserProviderApi implements UserProviderContract {

  //final GoogleSignIn _googleSignIn = GoogleSignIn( scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'] );

  @override
  Future<User> createUser(
      String username, String password, String emailAddress) {
    return Future<User>.value(User(username, password, emailAddress));
  }

  @override
  Future<User> currentUser() {
    return ParseUser.currentUser();
  }

  @override
  Future<ApiResponse> getCurrentUserFromServer() async {
    final ParseUser user = await ParseUser.currentUser();
    return getApiResponse<User>(await ParseUser.getCurrentUserFromServer(
        user?.get<String>(keyHeaderSessionToken)));
  }

  @override
  Future<ApiResponse> destroy(User user) async {
    return getApiResponse<User>(await user.destroy());
  }

  @override
  Future<ApiResponse> login(User user) async {
    return getApiResponse<User>(await user.login());
  }

  @override
  Future<ApiResponse> requestPasswordReset(User user) async {
    return getApiResponse<User>(await user.requestPasswordReset());
  }

  @override
  Future<ApiResponse> save(User user) async {
    return getApiResponse<User>(await user.save());
  }

  @override
  Future<ApiResponse> signUp(User user) async {
    return getApiResponse<User>(await user.signUp());
  }

  @override
  Future<ApiResponse> verificationEmailRequest(User user) async {
    return getApiResponse<User>(await user.verificationEmailRequest());
  }

  @override
  Future<ApiResponse> allUsers() async {
    return getApiResponse(await ParseUser.all());
  }

  @override
  void logout(User user) => user.logout();

  // @override
  // Future<ApiResponse> loginWithFacebook(User user) async {
  //
  //   final FacebookLogin facebookLogin = new FacebookLogin();
  //   final FacebookLoginResult result = await facebookLogin.logIn(['email']);
  //
  //   return getApiResponse<User>(await ParseUser.loginWith(
  //       'facebook',
  //       facebook(result.accessToken.token,
  //           result.accessToken.userId,
  //           result.accessToken.expires))
  //   );
  //
  // }

  // @override
  // Future<ApiResponse> loginWithGoogle(User user) async{
  //
  //   GoogleSignInAccount account = await _googleSignIn.signIn();
  //   GoogleSignInAuthentication authentication = await account.authentication;
  //
  //   return getApiResponse<User>(await ParseUser.loginWith(
  //       'google',
  //       google(authentication.accessToken, _googleSignIn.currentUser.id,
  //           authentication.idToken)));
  //
  // }
}