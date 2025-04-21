import 'package:ecommerce_app/features/home/data/model/category_model.dart';
import 'package:ecommerce_app/features/home/data/model/product_model.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constants.dart';

class ProductRepositoryImplementation extends ProductRepository {
  @override
  Future<ProductResponse> getProducts(int skip, int limit) async {
    try {
      final response = await ApiClient.instance.get(
        ApiConstants.getProducts(),
        queryParameters: {
          'skip': skip,
          'limit': limit,
        },
      );
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductResponse> getProductsByCategory(String category) async {
    try {
      final response = await ApiClient.instance.get(ApiConstants.productsByCategory(category));
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await ApiClient.instance.get(
        ApiConstants.getAllCategories,
      );

      final List<dynamic> data = response.data;

      return data.map((e) => Category.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductResponse> getSearchedProducts(String query) async {
    try {
      final response = await ApiClient.instance.get(
        ApiConstants.searchProducts(),
        queryParameters: {
          'q': query,
        },
      );
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
