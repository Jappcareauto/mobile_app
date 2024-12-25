import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';

class LocatedContainerWidget extends StatelessWidget{
  final bool haveButton ;
  LocatedContainerWidget({
    Key?key,
     required this.haveButton
}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(FluentIcons.location_12_regular , color: AppColors.black,),
            SizedBox(width: 5,),
            Text('Vehicle Located')
          ],
        ),
        SizedBox(height: 10,),
        haveButton == true ?
        SizedBox() :
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFEDE6),
            borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.only(
            top: 12,
            right: 16,
            left: 16,
            bottom: 16
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(FluentIcons.arrow_forward_16_filled , color: AppColors.primary,),
                  SizedBox(width: 5,),
                  Text('850m' , style: TextStyle(color:AppColors.primary , ),)
                ],
              ),
              SizedBox(height: 10,),
              
              Text('Take the next right' , style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14 , ),)
            ],
          ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width*0.45,
              height: 94,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(width: 1.84,color: Color(0xFFE5E2E1)),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Distance',style: TextStyle(color: Color(0xFF797676) ,
                      fontSize: 14 , fontWeight: FontWeight.w400)),
                  Row(
                    children: [
                      Icon(FluentIcons.location_12_regular , color: AppColors.primary,),
                      SizedBox(width: 5,),
                      Text('16km Away' , style: TextStyle(color: AppColors.primary ,
                          fontSize: 14 , fontWeight: FontWeight.w400),)
                    ],
                  )
                ],
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.4,
              height: 94,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(width: 1.84,color: Color(0xFFE5E2E1)),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: ImageComponent(
                width:MediaQuery.of(context).size.width*0.4 ,
                assetPath: AppImages.carWhite,
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        haveButton == true ?
        CustomButton(text: 'Take me there', onPressed: (){})
        : SizedBox()
      ],
    );
  }

}