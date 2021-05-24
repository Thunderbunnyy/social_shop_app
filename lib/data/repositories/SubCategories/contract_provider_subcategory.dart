import 'package:social_shop_app/data/base/api_response.dart';

abstract class SubCategoryProviderContract {

  Future<ApiResponse> getByCategoryId(String id);

  Future<ApiResponse> getAll();

}