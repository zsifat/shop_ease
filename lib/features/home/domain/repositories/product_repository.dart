import 'package:ecommerce_app/features/home/data/model/category_model.dart';

import '../../data/model/product_model.dart';

abstract class ProductRepository {
  Future<ProductResponse> getProducts(int skip, int limit);
  Future<ProductResponse> getProductsByCategory(String category);
  Future<List<Category>> getCategories();
  Future<ProductResponse> getSearchedProducts(String query);
}
