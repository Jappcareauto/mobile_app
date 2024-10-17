import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarContainer extends StatelessWidget {
  final String carName;
  final String carDetails;
  final String imagePath;
  final Color principalColor;

  const CarContainer({
    Key? key,
    required this.carName,
    required this.carDetails,
    required this.imagePath,
    required this.principalColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const DetailsCarPage()),
        // );
      },
      child: Container(
        width: Get.width * .85,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: principalColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              carName,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              carDetails,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Padding(
                  padding:  EdgeInsets.only(bottom: 16),
                  child:  Icon(
                    Icons.arrow_back,
                    textDirection: TextDirection.rtl,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: Get.width * .6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
