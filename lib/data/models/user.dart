import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/data/models/product.dart';

class User extends ParseUser implements ParseCloneable {
  User(String username, String password, String emailAddress)
      : super(username, password, emailAddress);

  User.clone() : this(null,null,null);

  @override
  User clone(Map<String, dynamic> map) => User.clone()..fromJson(map);

  static const String keyFollowersNumber = 'Followers';
  static const String keyFollowingNumber = 'Following';
  static const String keyDisplayPicture = 'DisplayPicture';
  static const String keyFullName = 'FullName';
  static const String keyProducts = 'Products';

  num get followers =>get<num>(keyFollowersNumber);
  set followers(num followers) => set<num>(keyFollowersNumber, followers);

  num get following =>get<num>(keyFollowingNumber);
  set following(num following) => set<num>(keyFollowingNumber, following);

  ParseFile get displayPicture => get<ParseFile>(keyDisplayPicture);
  set displayPicture(ParseFile displayPicture) =>
      set<ParseFile>(keyDisplayPicture, displayPicture);

  String get fullName => get<String>(keyFullName);
  set fullName(String products) => set<String>(keyFullName, fullName);

}