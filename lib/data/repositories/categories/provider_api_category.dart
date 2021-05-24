import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/category.dart';
import 'package:social_shop_app/data/repositories/categories/contract_provider_category.dart';

class CategoryProviderApi implements CategoryProviderContract {
  CategoryProviderApi();


  @override
  Future<ApiResponse> getAll() async {
    return getApiResponse<Category>(await Category().getAll());
  }

  @override
  Future<ApiResponse> getById(String id) async {
    return getApiResponse<Category>(await Category().getObject(id));
  }

  @override
  Future<ApiResponse> getNewerThan(DateTime date) async {
    final QueryBuilder<Category> query = QueryBuilder<Category>(Category())
      ..whereGreaterThan(keyVarCreatedAt, date);
    return getApiResponse<Category>(await query.query());
  }

}