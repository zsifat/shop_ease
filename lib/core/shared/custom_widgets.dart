import 'package:ecommerce_app/core/theme/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';

class ShopEaseAppBarTitle extends StatelessWidget {
  const ShopEaseAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Shop',
          style: AppTextStyles.t24b700_000,
        ),
        Text(
          'Ease',
          style: AppTextStyles.t24b700_EFF
        ),
      ],
    );
  }
}


class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final Function()? onClear;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.onSubmitted,
    this.onClear,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: controller?.text.isNotEmpty ?? false
            ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller?.clear();
                if(onClear!=null) {
                  onClear!();
                }
              },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8F6FF),
      ),
    );
  }
}


class ShimmerGrid extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const ShimmerGrid({
    super.key,
    this.itemCount = 10,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.7,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}


class LottieDisplay extends StatelessWidget {
  final String animationPath;
  final String message;
  final double animationSize;
  final TextStyle? textStyle;

  const LottieDisplay({
    super.key,
    required this.animationPath,
    required this.message,
    this.animationSize = 120,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            animationPath,
            width: animationSize,
            height: animationSize,
            repeat: true,
            reverse: false,
            animate: true,
            fit: BoxFit.contain,
            frameRate: FrameRate.max,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox();
            },
          ),
          Text(
            message,
            style: textStyle ?? AppTextStyles.t14b400_936,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final double rating;
  final double starSize;

  const RatingWidget({super.key, required this.rating, this.starSize = 14.0});

  @override
  Widget build(BuildContext context) {
    double validRating = rating.clamp(0.0, 5.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index < validRating) {
          return Icon(
            Icons.star,
            color: AppColors.brandColorEFF, // Dark color (filled star)
            size: starSize,
          );
        } else if (index < validRating && index + 1 > validRating) {
          return Icon(
            Icons.star_border,
            color: Colors.grey.shade100, // Light color (empty star)
            size: starSize,
          );
        } else {
          return Icon(
            Icons.star_border,
            color: AppColors.brandColorEFF, // Empty star (unfilled)
            size: starSize,
          );
        }
      }),
    );
  }
}


