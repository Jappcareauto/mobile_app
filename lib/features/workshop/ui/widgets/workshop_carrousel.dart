import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:shimmer/shimmer.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double? height;
  final MainAxisAlignment positionIndicator;
  final bool? haveBorderRadius;
  final bool isNetworkImage;
  const ImageCarousel(
      {super.key,
      required this.imageUrls,
      this.height,
      required this.positionIndicator,
      this.haveBorderRadius,
      this.isNetworkImage = false});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              padding: const EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    widget.haveBorderRadius != null ? 16 : 0),
                child: widget.isNetworkImage
                    ? CachedNetworkImage(
                        imageUrl: widget.imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(color: Colors.white),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          AppImages.shopCar,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : Image.asset(
                        widget.imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.height ?? 250,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 1,
            autoPlayCurve: Curves.easeIn,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: widget.positionIndicator,
            children: List.generate(widget.imageUrls.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Get.theme.primaryColor
                      : Colors.grey,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
