import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_colors.dart';

enum ChipSize { small, normal }

enum ChipStyle { bold, light }

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.status,
    this.variant = ChipSize.normal,
    this.style = ChipStyle.bold,
  });

  final String status;
  final ChipSize? variant;
  final ChipStyle? style;

  @override
  Widget build(BuildContext context) {
    Color chipColor;
    Color chipTextColor;

    if (status == 'IN_PROGRESS') {
      chipColor =
          style == ChipStyle.bold ? AppColors.orange : Color(0xFFFFEDE6);
      chipTextColor = style == ChipStyle.bold ? Colors.white : AppColors.orange;
    } else if (status == 'COMPLETED') {
      chipColor =
          ChipStyle.bold == style ? AppColors.green : Colors.green.shade100;
      chipTextColor = ChipStyle.bold == style ? Colors.white : Colors.green;
    } else {
      chipColor = style == ChipStyle.bold ? AppColors.red : Colors.red.shade100;
      chipTextColor = style == ChipStyle.bold ? Colors.white : Colors.red;
    }

    double chipPadding;
    TextStyle chipTextStyle;

    switch (variant) {
      case ChipSize.normal:
        chipPadding = 8;
        chipTextStyle = TextStyle(
            fontSize: 14, color: chipTextColor, fontWeight: FontWeight.bold);
        break;
      case ChipSize.small:
        chipPadding = 4;
        chipTextStyle = TextStyle(
            fontSize: 12, color: chipTextColor, fontWeight: FontWeight.bold);
        break;
      case null:
        chipPadding = 0;
        chipTextStyle = TextStyle(
            fontSize: 14, color: chipTextColor); // Assign a default value
        break;
    }

    return Chip(
      padding: EdgeInsets.symmetric(horizontal: chipPadding),
      backgroundColor: chipColor,
      label: Text(
        status.split("_").join(" "),
        style: chipTextStyle,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0, color: chipColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class ChipStatusPayWidget extends StatelessWidget {
  const ChipStatusPayWidget({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    Color chipColor;
    Color chipTextColor;

    if (status == 'UnPaid') {
      chipColor = const Color(0xFFFFEDE6);
      chipTextColor = Colors.orange;
    } else if (status == 'Paid') {
      chipColor = const Color(0xFFC4FFCD);
      chipTextColor = Colors.green;
    } else {
      chipColor = const Color(0xFFE0E0E0);
      chipTextColor = Colors.red;
    }
    return Chip(
      backgroundColor: chipColor,
      label: Text(
        status,
        style: TextStyle(color: chipTextColor),
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0, color: chipColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
