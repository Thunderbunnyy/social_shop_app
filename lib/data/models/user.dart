import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/data/models/product.dart';

class User extends ParseUser implements ParseCloneable {
  User(String username, String password, String emailAddress)
      : super(username, password, emailAddress);

  User.clone() : this(null, null, null);

  @override
  User clone(Map<String, dynamic> map) => User.clone()..fromJson(map);

  static const String keyFollowersNumber = 'Followers';
  static const String keyFollowingNumber = 'Following';
  static const String keyDisplayPicture = 'DisplayPicture';
  static const String keyProducts = 'Products';
  static const String keyProfessional = 'ProAccount';

  num get followers =>get<num>(keyFollowersNumber);
  set followers(num followers) => set<num>(keyFollowersNumber, followers);

  num get following =>get<num>(keyFollowingNumber);
  set following(num following) => set<num>(keyFollowingNumber, following);

  File get displayPicture => get<File>(keyDisplayPicture);
  set displayPicture(File displayPicture) =>
      set<File>(keyDisplayPicture, displayPicture);

  List<Product> get products => get<List<Product>>(keyProducts);
  set products(List<Product> products) => set<List<Product>>(keyProducts, products);

  bool get proAccount =>get<bool>(keyProfessional);
  set proAccount(bool proAccount) => set<bool>(keyProfessional, proAccount);

}