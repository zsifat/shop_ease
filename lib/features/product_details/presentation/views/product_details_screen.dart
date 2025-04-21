import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_textstyles.dart';
import 'package:ecommerce_app/features/home/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/shared/custom_widgets.dart';
import '../widgets/custom_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text('Product Details', style: AppTextStyles.t20b700_000),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.star, size: 18, color: Colors.black))
          ],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.only(bottom: 10),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: size.height * 0.5,
                        width: size.width,
                        child: NetworkImageCarousel(imageUrls: widget.product.images)),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                              overflow: TextOverflow.ellipsis,
                              widget.product.title,
                              style: AppTextStyles.t20b700_000),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              RatingWidget(
                                rating: widget.product.rating,
                                starSize: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(widget.product.rating.roundToDouble().toString(),
                                  style: AppTextStyles.t14b400_936),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text(widget.product.availabilityStatus,
                                  style: AppTextStyles.t14b400_936),
                              Spacer(),
                              Icon(CupertinoIcons.checkmark_shield_fill,
                                  color: AppColors.brandColorEFF, size: 16),
                              const SizedBox(width: 5),
                              Text(widget.product.warrantyInformation,
                                  style: AppTextStyles.t14b400_936),
                            ],
                          ),
                          const SizedBox(height: 15),
                          _buildDivider(),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('\$${widget.product.price}', style: AppTextStyles.t20b800_EEF),
                              const SizedBox(width: 10),
                              Text('\$${widget.product.discountPercentage.toStringAsFixed(2)}',
                                  style: AppTextStyles.t16b600_936
                                      .copyWith(decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                          if (widget.product.brand.trim().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0),
                              child: Row(
                                children: [
                                  Text('A product of', style: AppTextStyles.t14b400_936),
                                  const SizedBox(width: 10),
                                  Text(widget.product.brand, style: AppTextStyles.t16b600_936),
                                ],
                              ),
                            ),
                          const SizedBox(height: 15),
                          _buildDivider(),
                          const SizedBox(height: 15),
                          _buildHeading('Description'),
                          const SizedBox(height: 10),
                          Text(widget.product.description, style: AppTextStyles.t14b400_936),
                          const SizedBox(height: 20),
                          _buildHeading('Reviews'),
                          const SizedBox(height: 10),
                          buildReviewList(widget.product.reviews)
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
    );
  }

  Widget _buildHeading(String title) => Text(title, style: AppTextStyles.t16b600_936);
}
