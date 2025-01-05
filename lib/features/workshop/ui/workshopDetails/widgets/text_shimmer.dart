
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors
      (
        child: Container(
          width: 150,
          child: Text(
            ''
          ),
        ),
      baseColor: Colors.grey.withOpacity(.5),
      highlightColor: Colors.white,
    );
  }

}