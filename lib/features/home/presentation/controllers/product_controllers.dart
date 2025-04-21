import 'package:get/get.dart';
import '../../data/model/category_model.dart';
import '../../data/model/product_model.dart';
import '../../data/repositories/product_repository_implementation.dart';

class ProductController extends GetxController {
  // Observable properties for products
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  var totalProducts = 0.obs;
  var skip = 0.obs;
  var limit = 20.obs;
  var hasMore = true.obs;
  var searchTerm = ''.obs;

  // Repository for fetching data
  final ProductRepositoryImplementation repository = ProductRepositoryImplementation();

  // Observable list for categories
  var categories = <Category>[].obs;

  // Observable for selected category filter
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts(isRefresh: true);
  }

  // Fetch all products with optional category filtering
  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isLoading.value || !hasMore.value) return; // Prevent multiple fetch requests

    try {
      if (isRefresh) {
        resetPagination();
      }

      ProductResponse response;

      if(searchTerm.value.isNotEmpty){
        isLoading.value = true;
        response = await repository.getSearchedProducts(searchTerm.value);
        products.assignAll(response.products.cast<ProductModel>());
      }

      // Fetch products by selected category or all products
      else if (selectedCategory.value.isNotEmpty) {
        isLoading.value = true;

        response = await repository.getProductsByCategory(selectedCategory.value);
        products.assignAll(response.products.cast<ProductModel>());

        if (response.total != null) {
          totalProducts.value = response.total;
        }

        skip.value += limit.value;

        // Stop fetching when all products are loaded
        if (products.length >= totalProducts.value) {
          hasMore.value = false;
        }
      } else {
        if (skip.value == 0) {
          isLoading.value = true; // Show loading indicator when fetching the first batch
        }
        response = await repository.getProducts(skip.value, limit.value);
        if (response.products != null) {
          products.addAll(response.products.cast<ProductModel>());
        }

        // Update total products and pagination state
        if (response.total != null) {
          totalProducts.value = response.total;
        }

        skip.value += limit.value;

        // Stop fetching when all products are loaded
        if (products.length >= totalProducts.value) {
          hasMore.value = false;
        }
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch categories for filtering products
  Future<void> fetchCategories() async {
    try {
      final response = await repository.getCategories();
      categories.assignAll(response);
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // Select a category for filtering
  void selectCategory(String category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
      resetPagination();
      fetchProducts(isRefresh: true);
    }
  }

  // Update the search term for product filtering
  void updateSearchTerm(String term) {
    searchTerm.value = term;
    fetchProducts();
  }

  // Clear the search term
  void clearSearchTerm() {
    searchTerm.value = '';
    fetchProducts(isRefresh: true);
  }

  // Helper function to reset pagination state
  void resetPagination() {
    skip.value = 0;
    hasMore.value = true;
    products.clear();
  }
}
