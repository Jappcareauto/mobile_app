import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/shop/ui/bag/controllers/bag_controller.dart';
import 'package:jappcare/features/shop/ui/bag/widgets/items_widgets.dart';
import 'package:jappcare/features/shop/ui/oderSummary/widgets/payment_methode_wigets.dart';
import 'controllers/oder_summary_controller.dart';
import 'package:get/get.dart';

class OderSummaryScreen extends GetView<OderSummaryController> {
  final BagController cartController = Get.put(BagController(Get.find()));

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(
        title:  'Oder Summary',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items'),
                ],
              ),
              SizedBox(height: 10),
              ...List.generate(2, (index) {
                return ItemContainer(
                  modifyQuantity: false,
                  imageUrl: "https://via.placeholder.com/150",
                  assetPath: AppImages.carWhite,
                  title: "Lamborghini Urus Headlight",
                  price: 125000,
                  quantity: cartController.quantity,
                  onIncrement: cartController.incrementQuantity,
                  onDecrement: cartController.decrementQuantity,
                );
              }),
              SizedBox(height: 10),
              Container(

                padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 20),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(12)
                ),
                child:Row(
                  children: [
                    Text('Total' , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 , color: Color(0xFF797676) , fontFamily:'PlusJakartaSans'),),
                    SizedBox(width: MediaQuery.of(context).size.width*.5,),

                    Text("${NumberFormat('#,###').format(1240000)} Frs" , style: TextStyle(fontSize:16 , fontWeight: FontWeight.w600 , color: Get.theme.primaryColor ),)
                  ],
                )
              ),
              SizedBox(height: 10,),

              PaymentMethodeWidget(buttonText: 'Place Oder', ontap:(){ controller.goToOderSummary2(); },)
            ],

          ),
        )
      )
    );
  }
}
