//Don't translate me
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  const ImageComponent({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
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
          color: color,
          placeholderBuilder: (context) => _buildShimmer(),
          fit: BoxFit.cover,
          width: width,
          height: height,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: imageUrl!,
          placeholder: (context, url) => _buildShimmer(),
          errorWidget: (context, url, error) => _buildDefaultImage(),
          fit: BoxFit.cover,
        );
      }
    } else if (file != null) {
      return Image.file(
        file!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      );
    } else if (assetPath != null) {
      if (assetPath!.endsWith('.svg')) {
        return SvgPicture.asset(
          assetPath!,
          color: color,
          fit: BoxFit.cover,
          width: width,
          height: height,
          placeholderBuilder: (context) => _buildShimmer(),
        );
      } else {
        return Image.asset(
          assetPath!,
          width: width,
          height: height,
          fit: BoxFit.cover,
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
    return Image.asset(
      AppImages.noImage, // Chemin de l'image par défaut
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
