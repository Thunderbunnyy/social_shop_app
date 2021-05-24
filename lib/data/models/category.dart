import 'package:parse_server_sdk/parse_server_sdk.dart';

const String keyCategory ='Category';
const String keyName = 'name';

class Category extends ParseObject implements ParseCloneable{

  Category() : super(keyCategory);
  Category.clone() : this();

  @override
  Category clone(Map<String, dynamic> map) => Category.clone()..fromJson(map);

  String get name => get<String>(keyName);
  set name(String name) => set<String>(keyName, name);

  // Category.fromParse(ParseObject parseObject) {
  //   id = parseObject.objectId;
  //   name = parseObject.get('name');
  // }

  
  //List<SubCategory> subCategories;

  //List<SubCategory> list;

  // List<SubCategory> getSubs(
  //   var queryBuilder = QueryBuilder<SubCategory>(subCategory())
  //       ..whereEquals(SubCategory.Category)
  // }

  // getSubcategories() async {
  //   QueryBuilder<ParseObject> subcategoriesQuery =
  //       QueryBuilder<ParseObject>(ParseObject('SubCategory'))
  //         ..whereEqualTo('categoryId', id);
  //
  //   ParseResponse apiResponse = await subcategoriesQuery.query();
  //
  //   if (apiResponse.success) {
  //     return list =
  //         apiResponse.results.map((p) => SubCategory.fromParse(p)).toList();
  //   }
  // }
  //
  // static Category convertParseObjectToCategory(ParseObject object) {
  //   var category = Category();
  //   category.name = object.get<String>('name');
  //   category.id = object.get<String>('categoryId');
  //   return category;
  // }
//
// @override
// String toString() {
//   return 'Category{id: $id, name: $name, subCategories : $subCategories}';
// }
}
