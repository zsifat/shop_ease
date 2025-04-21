import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/utils/helper_methods.dart';
import 'package:ecommerce_app/core/theme/app_textstyles.dart';
import 'package:ecommerce_app/features/home/data/model/category_model.dart';
import 'package:ecommerce_app/features/home/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/product_controllers.dart';

class ProductContainer extends StatelessWidget {
  final ProductModel product;
  const ProductContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 233,
      width: size.width * 0.4,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          top: BorderSide.none,
          bottom: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  product.title,
                  style: AppTextStyles.t14b400_936
                ),
                const SizedBox(height: 5),
                Text(
                  HelperMethods.toTitleCase(product.category),
                  style: AppTextStyles.t12b400_936,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '\$${product.price}',
                      style: AppTextStyles.t14b600_EFF
                    ),
                    const Spacer(),
                    Icon(
                      Icons.star,
                      size: 14,
                      color: AppColors.brandColorEFF,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      '${product.rating.roundToDouble()}',
                      style: AppTextStyles.t12b400_936
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterBottomSheet extends StatelessWidget {
  final String title;
  final List<Category> items;

  const FilterBottomSheet({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      shouldCloseOnMinExtent: true,
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              SizedBox(
                height: 10,
              ),
              _buildItemList(scrollController), // Pass scrollController to ListView
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
      child: Text(
        title,
        style: AppTextStyles.t16b600_936
      ),
    );
  }

  Widget _buildItemList(ScrollController scrollController) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController, // Attach the scroll controller here
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildItemRow(items[index].name);
        },
      ),
    );
  }

  Widget _buildItemRow(String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
        onTap: () {
          Get.find<ProductController>().selectCategory(item);
          Get.back();
        },
        child: Row(
          children: [
            Text(
              item,
              style: AppTextStyles.t16b400_936,
            ),
            const Spacer(),
            const Icon(CupertinoIcons.chevron_right),
          ],
        ),
      ),
    );
  }
}
