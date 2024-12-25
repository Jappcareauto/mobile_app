import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';

class SearchVehicleWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(FluentIcons.location_12_regular , color: AppColors.black,),
            SizedBox(width: 5,),
            Text('Finding your vehicle')
          ],
        ),
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: 200,
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(width: 1.84,color: Color(0xFFE5E2E1)),
              borderRadius: BorderRadius.circular(20)
          ),
          child: ImageComponent(
            assetPath: AppImages.carWhite,
          ),
        ),
        SizedBox(height: 10,),

        Text('Porsche Taycan Turbo S')
      ],
    );
  }
  
}
