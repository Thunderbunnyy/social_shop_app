import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/data/models/sub_category.dart';
import 'package:social_shop_app/data/models/user.dart';

const String keyProduct = 'Product';
const String keyTitle ='Title';
const String keyDescription='Description';
const String keyPrice= 'Price';
const String keyOptions = 'Options' ;
const String keyImages = 'Images';
const String keyOwner = 'Owner';
const String keyOwnerId = 'Owner_id';
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

  String get price =>get<String>(keyPrice);
  set price(String price) => set<String>(keyPrice, price);

  Map<String,dynamic> get options =>get<Map<String,dynamic>>(keyOptions);
  set options(Map<String,dynamic> options) => set<Map<String,dynamic>>(keyOptions, options);

  List<dynamic> get images =>get<List<dynamic>>(keyImages);
  set images(List<dynamic> images) => set<List<dynamic>>(keyImages, images);

  String get owner => get<String>(keyOwner);
  set owner(String owner) => set<String>(keyOwner,owner);

  String get ownerId => get<String>(keyOwnerId);
  set ownerId(String ownerId) => set<String>(keyOwnerId,owner);

  bool get status => get<bool>(keyStatus);
  set status(bool status) => set<bool>(keyStatus, status);

  String get likes =>get<String>(keyLikes);
  set likes(String likes) => set<String>(keyLikes, likes);

  SubCategory get subcategory => get<SubCategory>(keySubcategoryId);
  set subcategory(SubCategory subcategory) => set<SubCategory>(keySubcategoryId, subcategory);

}
