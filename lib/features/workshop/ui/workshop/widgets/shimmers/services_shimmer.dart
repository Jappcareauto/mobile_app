import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ServicesShimmer extends StatelessWidget {
  final bool isHorizontal;
  const ServicesShimmer({super.key, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.withValues(alpha: .8),
                  highlightColor: Colors.grey.withValues(alpha: .6),
                  child: Container(
                    width: 100,
                    height: 50,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 10,
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 100,
                    color: Colors.white,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 100,
                    color: Colors.white,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 100,
                    color: Colors.white,
                  ),
                ),
              ],
            ));

    //  Container(
    //   padding: const EdgeInsets.all(16),
    //   child: Column(
    //     children: [
    //       Shimmer.fromColors(
    //         baseColor: Colors.grey[300]!,
    //         highlightColor: Colors.grey[100]!,
    //         child: Container(
    //           height: 100,
    //           color: Colors.white,
    //         ),
    //       ),
    //       const SizedBox(height: 8),
    //       Shimmer.fromColors(
    //         baseColor: Colors.grey[300]!,
    //         highlightColor: Colors.grey[100]!,
    //         child: Container(
    //           height: 100,
    //           color: Colors.white,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
