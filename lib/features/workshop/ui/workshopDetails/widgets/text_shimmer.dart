
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  const TextShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.5),
      highlightColor: Colors.white,
      child: Container(
        width: 150,
        height: 20, // Hauteur simulant une ligne de texte
        color: Colors.grey, // Couleur de fond pour le shimmer
      ),
    );
  }

}