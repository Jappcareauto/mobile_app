import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderWidget extends StatelessWidget {
  final bool dense;

  const LoaderWidget({Key? key, this.dense = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dense ? Get.height : null,
      width: dense ? Get.width : null,
      color: dense ? Colors.white : Colors.transparent,
      child: Center(
        child: LoadingAnimationWidget.beat(
            size: 20, color: dense ? Get.theme.primaryColor : Colors.white),
      ),
    );
  }
}
