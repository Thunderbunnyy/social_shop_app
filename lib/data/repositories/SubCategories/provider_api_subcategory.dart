import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/category.dart';
import 'package:social_shop_app/data/models/sub_category.dart';
import 'package:social_shop_app/data/repositories/SubCategories/contract_provider_subcategory.dart';

class SubCategoryProviderApi implements SubCategoryProviderContract {


  @override
  Future<ApiResponse> getAll() async {
    return getApiResponse<SubCategory>(await SubCategory().getAll());
  }

  @override
  Future<ApiResponse> getByCategoryId(String id) async {

    // QueryBuilder<ParseObject> subcategoriesQuery =
    // QueryBuilder<ParseObject>(ParseObject('SubCategory'))
    //   ..whereEqualTo('categoryId', id);

    QueryBuilder<SubCategory> subcategoriesQuery =
    QueryBuilder<SubCategory>(SubCategory())
      ..whereEqualTo('categoryId', id);

    return getApiResponse<Category>(await subcategoriesQuery.query());
  }

}