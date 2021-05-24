import 'package:social_shop_app/data/base/api_response.dart';

abstract class CategoryProviderContract {

  Future<ApiResponse> getById(String id);

  Future<ApiResponse> getAll();

  Future<ApiResponse> getNewerThan(DateTime date);
}