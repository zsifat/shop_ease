import 'package:ecommerce_app/core/constants/app_constants.dart';
import 'package:ecommerce_app/core/shared/custom_widgets.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_textstyles.dart';
import 'package:ecommerce_app/features/home/data/model/product_model.dart';
import 'package:ecommerce_app/features/home/presentation/controllers/product_controllers.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../product_details/presentation/views/product_details_screen.dart';
import '../controllers/network_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.find<ProductController>();
  final NetworkController networkController = Get.find<NetworkController>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - MediaQuery.of(context).size.height/2) {
        productController.fetchProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: ShopEaseAppBarTitle(),
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      body: Obx(() {
        if (networkController.isConnected.value) {
          final productList = productController.products.value;
          return RefreshIndicator(
            onRefresh: productController.fetchProducts,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Search for products',
                              controller: searchTextController,
                              prefixIcon: Icons.search,
                              onChanged: (value) {
                                productController.updateSearchTerm(value);
                              },
                              onClear: () {
                                productController.clearSearchTerm();
                              },
                              onTextCleared: () {
                                productController.clearSearchTerm();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return FilterBottomSheet(
                                      title: 'Categories',
                                      items: productController.categories,
                                    );
                                  },
                                );
                              },
                              icon: SvgPicture.asset(
                                AppConstants.filterIcon,
                                width: 26,
                                height: 26,
                                color: AppColors.brandColorEFF,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF8F6FF),
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 0),
                    child: Column(
                      children: [
                        productController.selectedCategory.value.isNotEmpty &&
                                productList.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Showing ${productController.products.length} results for ${productController.selectedCategory.value}',
                                      style: AppTextStyles.t12b500_936),
                                  TextButton(
                                    onPressed: () {
                                      productController.selectCategory('');
                                    },
                                    child: Text('Clear Filter', style: AppTextStyles.t12b600_EFF),
                                  )
                                ],
                              )
                            : SizedBox(
                                height: size.width * 0.03,
                              ),
                        Expanded(child: _buildProductContent(productList)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return LottieDisplay(
              animationPath: AppConstants.noInternet,
              message: 'No Internet,\nPlease Turn on Internet Connection');
        }
      }),
    );
  }

  Widget _buildProductContent(List<ProductModel> productList) {
    if (productController.isLoading.value) {
      return ShimmerGrid();
    }

    if (productList.isNotEmpty) {
      return GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(ProductDetailsScreen(product: productList[index]));
            },
            child: ProductContainer(
              product: productList[index],
            ),
          );
        },
      );
    }

    return LottieDisplay(
      animationPath: AppConstants.noItemLottie,
      message: 'No Items Found',
    );
  }
}
