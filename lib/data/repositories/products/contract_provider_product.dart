
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';

abstract class ProductProviderContract {
  Future<ApiResponse> add(Product item);

  Future<ApiResponse> create (Product item);

  Future<ApiResponse> addAll(List<Product> items);

  Future<ApiResponse> update(Product item);

  Future<ApiResponse> updateAll(List<Product> items);

  Future<ApiResponse> remove(Product item);

  Future<ApiResponse> getById(String id);

  Future<ApiResponse> moreProductsFromUser(String id, String productId);

  Future<ApiResponse> similarProducts(String id, String productId);

  Future<ApiResponse> getAll();

  Future<ApiResponse> getNewerThan(DateTime date);

  Future<ApiResponse> searchForProduct(String id);
}