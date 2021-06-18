import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/repositories/products/contract_provider_product.dart';

class ProductProviderApi implements ProductProviderContract {
  ProductProviderApi();

  @override
  Future<ApiResponse> create(Product item) async {
    return getApiResponse<Product>(await item.create());
  }

  @override
  Future<ApiResponse> add(Product item) async {
    return getApiResponse<Product>(await item.save());
  }

  @override
  Future<ApiResponse> addAll(List<Product> items) async {
    final List<Product> responses = [];

    for (final Product item in items) {
      final ApiResponse response = await add(item);

      if (!response.success) {
        return response;
      }

      response?.results?.forEach(responses.add);
    }

    return ApiResponse(true, 200, responses, null);
  }

  @override
  Future<ApiResponse> getAll() async {
    return getApiResponse<Product>(await Product().getAll());
  }

  @override
  Future<ApiResponse> getById(String id) async {
    return getApiResponse<Product>(await Product().getObject(id));
  }

  @override
  Future<ApiResponse> getNewerThan(DateTime date) async {
    final QueryBuilder<Product> query = QueryBuilder<Product>(Product())
      ..whereGreaterThan(keyVarCreatedAt, date);
    return getApiResponse<Product>(await query.query());
  }

  @override
  Future<ApiResponse> remove(Product item) async {
    return getApiResponse<Product>(await item.delete());
  }

  @override
  Future<ApiResponse> update(Product item) async {
    return getApiResponse<Product>(await item.save());
  }

  @override
  Future<ApiResponse> updateAll(List<Product> items) async {
    final List<Product> responses = [];

    for (final Product item in items) {
      final ApiResponse response = await update(item);

      if (!response.success) {
        return response;
      }

      response?.results?.forEach(responses.add);
    }

    return ApiResponse(true, 200, responses, null);
  }

  @override
  Future<ApiResponse> moreProductsFromUser(String username, String productId) async {
    QueryBuilder<Product> products = QueryBuilder<Product>(Product())
    ..whereNotEqualTo('objectId', productId)
      ..whereEqualTo('Owner', username);

    return getApiResponse<Product>(await products.query());
  }

  @override
  Future<ApiResponse> similarProducts(String id, String productId) async {
    QueryBuilder<Product> products = QueryBuilder<Product>(Product())
      ..whereNotEqualTo('objectId', productId)
      ..whereEqualTo('SubcategoryId', id);

    return getApiResponse<Product>(await products.query());
  }

  @override
  Future<ApiResponse> searchForProduct(String id) async {
    QueryBuilder<Product> products = QueryBuilder<Product>(Product())
      ..whereEqualTo('SubcategoryId', id);

    return getApiResponse<Product>(await products.query());
  }


}