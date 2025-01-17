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
              Obx(
                    () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    return ItemContainer(
                      assetPath: '',
                      total: cartController.totalPrices.value.obs,
                      imageUrl: item.imageUrl,
                      title: item.title,
                      price: item.price.toInt(),
                      quantity: item.quantity.obs,
                      onDelete: (){
                        cartController.showDeleteModal(item.id);
                      },
                      onIncrement: () => cartController.updateQuantity(item.id, item.quantity + 1),
                      onDecrement: () => cartController.updateQuantity(item.id, item.quantity - 1),
                      modifyQuantity: false,
                    );
                  },
                ),
              ),
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

                    Text("${NumberFormat('#,###').format(cartController.totalPrices.value)} Frs" , style: TextStyle(fontSize:16 , fontWeight: FontWeight.w600 , color: Get.theme.primaryColor ),)
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
