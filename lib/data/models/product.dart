import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/data/models/sub_category.dart';
import 'package:social_shop_app/data/models/user.dart';

const String keyProduct = 'product';
const String keyTitle ='Title';
const String keyDescription='Description';
const String keyPrice= 'Price';
const String keyOptions = 'Options' ;
const String keyImages = 'Images';
const String keyOwner = 'Owner';
const String keyStatus = 'Status';
const String keyLikes = 'Likes';
const String keySubcategoryId = 'SubcategoryId';


class Product extends ParseObject implements ParseCloneable{

  Product() : super(keyProduct);
  Product.clone() : this();


  @override
  Product clone(Map<String, dynamic> map) => Product.clone()..fromJson(map);

  String get title => get<String>(keyTitle);
  set title(String title) => set<String>(keyTitle, title);

  String get description => get<String>(keyDescription);
  set description(String description) => set<String>(keyDescription, description);

  num get price =>get<num>(keyPrice);
  set price(num price) => set<num>(keyPrice, price);

  Map<String,dynamic> get options =>get<Map<String,dynamic>>(keyOptions);
  set options(Map<String,dynamic> options) => set<Map<String,dynamic>>(keyOptions, options);

  List<dynamic> get images =>get<List<dynamic>>(keyImages);
  set images(List<dynamic> images) => set<List<dynamic>>(keyImages, images);

  User get owner => get<User>(keyOwner);
  set owner(User owner) => set<User>(keyOwner,owner);

  bool get status => get<bool>(keyStatus);
  set status(bool status) => set<bool>(keyStatus, status);

  num get likes =>get<num>(keyLikes);
  set likes(num likes) => set<num>(keyLikes, likes);

  SubCategory get subcategory => get<SubCategory>(keySubcategoryId);
  set subcategory(SubCategory subcategory) => set<SubCategory>(keySubcategoryId, subcategory);

}
