import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TestimonieShimmer extends StatelessWidget {
  const TestimonieShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) { // Génère plusieurs conteneurs
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.5),
              highlightColor: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16), // Coins arrondis
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
