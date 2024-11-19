import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;

  ImageCarousel({required this.imageUrls});

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
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  widget.imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 250,
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
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
