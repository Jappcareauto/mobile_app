import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/home/domain/entities/get_tips_list.entity.dart';

class TipModalBottomWidget extends StatelessWidget {
  final TipEntity tip;

  const TipModalBottomWidget({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      // height: 390,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        spacing: 20,
        children: [
          Container(
            width: 28,
            height: 5,
            decoration: BoxDecoration(
                color: AppColors.black, borderRadius: BorderRadius.circular(6)),
          ),
          Text("Tip",
              style: Get.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text(tip.title,
              style: Get.textTheme.bodyMedium?.copyWith(
                  color: Get.theme.primaryColor, fontWeight: FontWeight.bold)),
          Text(tip.description, style: Get.textTheme.bodyMedium),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomButton(
                  // strech: false,
                  text: "Done",
                  onPressed: Get.back,
                ),
              ),
              // Flexible(
              //   child: CustomButton(
              //     strech: false,
              //     text: "Next",
              //     onPressed: Get.back,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
