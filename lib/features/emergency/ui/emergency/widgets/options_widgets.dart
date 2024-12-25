import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class OptionWidgets extends StatelessWidget{
  @override
    final String title ;
    final VoidCallback ontap ;
    OptionWidgets({
      Key?key,
      required this.title,
      required this.ontap
}):super(key: key);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 20
        ),
        padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.secondary,

          borderRadius: BorderRadius.circular(16),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

                Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 14),
                ),
                Icon(FluentIcons.arrow_right_16_filled)
          ],
        ),
      ),
    );
  }

}