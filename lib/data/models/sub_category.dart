import 'package:parse_server_sdk/parse_server_sdk.dart';

const String keySubCategory ='SubCategory';
const String keyCategory='categoryId';
const String keyName= 'name';


class SubCategory extends ParseObject implements ParseCloneable{

  SubCategory() : super(keySubCategory);
  SubCategory.clone() : this();

  @override
  SubCategory clone(Map<String, dynamic> map) => SubCategory.clone()..fromJson(map);

  String get name => get<String>(keyName);
  set name(String name) => set<String>(keyName, name);

  String get categoryId => get<String>(keyCategory);


}
