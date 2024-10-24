import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../utils/app_dimensions.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool strech;
  final bool haveBorder;
  final Color? borderColor;
  final RxBool? isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(AppDimensions.radiusSmall)),
    this.suffixIcon,
    this.strech = true,
    this.haveBorder = false,
    this.borderColor,
    this.prefixIcon,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final loading = isLoading ?? false.obs;
    return Obx(() => SizedBox(
          width: strech ? Get.context!.width : width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.black,
              overlayColor: Colors.black12,
              elevation: .0,
              backgroundColor:
                  color ?? (haveBorder ? Colors.transparent : null),
              shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                  side: haveBorder
                      ? BorderSide(color: borderColor ?? Colors.black)
                      : BorderSide.none),
            ),
            onPressed: loading.value ? null : onPressed,
            child: loading.value
                ? LoadingAnimationWidget.beat(
                    color:
                        textColor ?? (haveBorder ? Colors.black : Colors.white),
                    size: 20)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (suffixIcon != null) SizedBox(),
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (prefixIcon != null) prefixIcon!,
                              if (prefixIcon != null) const SizedBox(width: 8),
                              Text(
                                text,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: textColor ??
                                          (haveBorder
                                              ? Colors.black
                                              : Colors.white),
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (suffixIcon != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 8),
                            suffixIcon!,
                          ],
                        ),
                    ],
                  ),
          ),
        ));
  }
}
