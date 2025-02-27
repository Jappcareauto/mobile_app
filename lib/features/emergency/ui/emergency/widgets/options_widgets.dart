import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class OptionWidgets extends StatelessWidget{
  @override
    final String title ;
    final VoidCallback ontap ;
    const OptionWidgets({
      super.key,
      required this.title,
      required this.ontap
});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.secondary,

          borderRadius: BorderRadius.circular(16),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

                Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600 , fontSize: 14),
                ),
                const Icon(FluentIcons.arrow_right_16_filled)
          ],
        ),
      ),
    );
  }

}