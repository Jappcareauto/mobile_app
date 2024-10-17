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

    if (status == 'In Progress') {
      chipColor = AppColors.orange.withOpacity(.1);
      chipTextColor = AppColors.orange;
    } else if (status == 'Completed') {
      chipColor = AppColors.green.withOpacity(.1);
      chipTextColor = Colors.green;
    } else {
      chipColor = AppColors.green;
      chipTextColor = Colors.black;
    }
    return Chip(
      backgroundColor: chipColor,
      label: Text(
        status,
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
