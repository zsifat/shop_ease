import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/shared/custom_widgets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../home/data/model/product_model.dart';

class NetworkImageCarousel extends StatefulWidget {
  final List<String> imageUrls;// List of image URLs

  const NetworkImageCarousel({super.key, required this.imageUrls});

  @override
  State<NetworkImageCarousel> createState() => _NetworkImageCarouselState();
}

class _NetworkImageCarouselState extends State<NetworkImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.imageUrls[index],
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      color: Colors.white,
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.imageUrls.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: const Color(0xFF6B4EFF)),
            color: _currentPage == index ? const Color(0xFF6B4EFF) : Colors.white,
          ),
        );
      }),
    );
  }
}

Widget buildReviewList(List<Review> reviews) {
  return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColorCCC.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.brandColorEFF,
                    child: Text(
                      review.reviewerName[0].toUpperCase(),
                      style: AppTextStyles.t16b600_936.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    review.reviewerName,
                    style: AppTextStyles.t14b600_936,
                  ),
                  const Spacer(),
                  RatingWidget(rating: review.rating, starSize: 14),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                review.comment,
                style: AppTextStyles.t14b400_936,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 8,
        );
      },
      itemCount: reviews.length);
}
