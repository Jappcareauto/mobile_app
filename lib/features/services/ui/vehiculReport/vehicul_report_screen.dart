import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/services/ui/vehiculReport/widgets/card_details_widget.dart';
import 'package:jappcare/features/shop/ui/shop/widgets/tabs_list_widgets.dart';
import 'package:jappcare/main.dart';
import 'controllers/vehicul_report_controller.dart';
import 'package:get/get.dart';

class VehiculReportScreen extends GetView<VehiculReportController> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(title: 'Vehicle Report') ,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'Porsche Taycan Turbo S',
                style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 22 , color: Color(0xFFFB7C37)),
              ),
              SizedBox(height: 10,),
              Text(
                '2024, RWD',
                style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 14),
              ),
              SizedBox(height: 10,),

              CustomButton(
                  text: 'Download Report',
                  strech: false,
                  width: 200,
                  borderRadius: BorderRadius.circular(30),
                  haveBorder: true,
                  onPressed: (){}),
              ImageComponent(
                assetPath: AppImages.carWhite,
              ),
             TabsListWidgets(
                 tabs: controller.texts, 
                 selectedFilter: controller.selectedFilter, 
                 selectedTabs: controller.selectedTabs,
                 borderRadius: BorderRadius.circular(30),
                 haveBorder: false
             ),
              SizedBox(height: 20,),
              CardDetailsWidget()


            ],
          ),


        )
      )

    );
  }
}
