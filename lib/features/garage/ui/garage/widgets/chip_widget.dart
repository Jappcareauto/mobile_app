import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    Color chipColor;
    Color chipTextColor;

    if (status == 'IN_PROGRESS') {
      chipColor = Color(0xFFFFEDE6);
      chipTextColor = AppColors.orange;
    } else if (status == 'COMPLETED') {
      chipColor = AppColors.green.withValues(alpha: .1);
      chipTextColor = Colors.green;
    } else {
      chipColor = AppColors.red;
      chipTextColor = Colors.white;
    }
    return Chip(
      backgroundColor: chipColor,
      label: Text(
        status.split("_").join(" "),
        style: TextStyle(color: chipTextColor, fontWeight: FontWeight.bold),
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
