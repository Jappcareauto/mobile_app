import 'package:flutter/cupertino.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class DetailResponseWidgets extends StatelessWidget{
  const DetailResponseWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16)
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Your Location',
                style:TextStyle(color: AppColors.greyText ,  fontSize: 12 , fontWeight: FontWeight.w400) ,

              ),
              SizedBox(height: 5,),
              Text(
                  'Live Location',
                style:TextStyle(color: AppColors.primary ,  fontSize: 14 , fontWeight: FontWeight.w600) ,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                  'Arriving In',
                style:TextStyle(color: AppColors.greyText ,  fontSize: 12 , fontWeight: FontWeight.w400) ,

              ),
              SizedBox(height: 5,),
              Text(
                '-15mins',
                style:TextStyle(color: AppColors.primary ,  fontSize: 14 , fontWeight: FontWeight.w600) ,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                  'Distance',
                style:TextStyle(color: AppColors.greyText ,  fontSize: 12 , fontWeight: FontWeight.w400) ,

              ),
              SizedBox(height: 5,),
              Text(
                '12km',
                style:TextStyle(color: AppColors.primary ,  fontSize: 14 , fontWeight: FontWeight.w600) ,
              ),
            ],
          )
        ],
      ),
    );
  }

}