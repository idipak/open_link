import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ArticleThumbnail extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool isEmpty;

  const ArticleThumbnail({
    super.key,
    this.width = 46,
    this.height = 46,
    this.borderRadius = 11,
    this.isEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.thumbnailBg,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: isEmpty
          ? null
          : Center(
              child: Icon(
                Icons.image_outlined,
                color: AppColors.mutedText,
                size: height * 0.45,
              ),
            ),
    );
  }
}
