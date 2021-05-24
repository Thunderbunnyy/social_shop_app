

import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/user.dart';

abstract class UserProviderContract {
  Future<User> createUser(
      String username, String password, String emailAddress);
  Future<User> currentUser();
  Future<ApiResponse> signUp(User user);
  Future<ApiResponse> login(User user);
  //Future<ApiResponse> loginWithFacebook(User user);
  //Future<ApiResponse> loginWithGoogle(User user);
  void logout(User user);
  Future<ApiResponse> getCurrentUserFromServer();
  Future<ApiResponse> requestPasswordReset(User user);
  Future<ApiResponse> verificationEmailRequest(User user);
  Future<ApiResponse> save(User user);
  Future<ApiResponse> destroy(User user);
  Future<ApiResponse> allUsers();
}