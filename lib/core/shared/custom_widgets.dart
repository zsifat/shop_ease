import 'dart:async';
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


class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Function()? onTextCleared;
  final Function()? onClear;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.onChanged,
    this.onTextCleared,
    this.onClear,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      setState(() {});
      if (_controller.text.isEmpty && widget.onTextCleared != null) {
        widget.onTextCleared!();
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    if(value.isNotEmpty){
      _debounce = Timer(const Duration(seconds: 1), () {
        if (widget.onChanged != null) {
            widget.onChanged!(value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      onChanged: _onChanged,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _controller.clear();
            if (widget.onClear != null) {
              widget.onClear!();
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

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isCancel;
  const CustomButton({super.key, required this.text, required this.onPressed, this.isCancel =false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: !isCancel ? const Color(0xFF6B4EFF) : const Color(0xFFF4F4F6),
            side: isCancel ? const BorderSide(color: Color(0xFF6B4EFF) ) : BorderSide.none,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
            fixedSize: const Size(double.infinity, double.infinity)),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            color: isCancel ?  const Color(0xFF6B4EFF) :Colors.white,
          ),
        ),
      ),
    );
  }
}

