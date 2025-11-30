//Don't translate me
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageComponent extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final File? file;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxBorder? border;
  final double? elevation;
  final VoidCallback? onTap;
  final Color? color;
  final Widget? onErrorWidget;
  final BoxFit fit;

  const ImageComponent({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.file,
    this.width,
    this.height,
    this.borderRadius,
    this.border,
    this.elevation,
    this.onTap,
    this.color,
    this.onErrorWidget,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl != null) {
      if (imageUrl!.endsWith('.svg')) {
        return SvgPicture.network(
          imageUrl!,
          colorFilter: ColorFilter.mode(
              color ?? Get.theme.primaryColor, BlendMode.color),
          placeholderBuilder: (context) => _buildShimmer(),
          fit: fit,
          width: width,
          height: height,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: imageUrl!,
          placeholder: (context, url) => _buildShimmer(),
          errorWidget: (context, url, error) => _buildDefaultImage(),
          fit: fit,
        );
      }
    } else if (file != null) {
      return Image.file(
        file!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      );
    } else if (assetPath != null) {
      if (assetPath!.endsWith('.svg')) {
        return SvgPicture.asset(
          assetPath!,
          colorFilter: ColorFilter.mode(
              color ?? Get.theme.primaryColor, BlendMode.color),
          fit: fit,
          width: width,
          height: height,
          placeholderBuilder: (context) => _buildShimmer(),
        );
      } else {
        return Image.asset(
          assetPath!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
          color: color,
          colorBlendMode: BlendMode.color,
        );
      }
    } else {
      return _buildDefaultImage();
    }
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDefaultImage() {
    return onErrorWidget ??
        Image.asset(
          AppImages.noImage, // Chemin de l'image par défaut
          width: width,
          height: height,
          fit: fit,
        );
  }
}
