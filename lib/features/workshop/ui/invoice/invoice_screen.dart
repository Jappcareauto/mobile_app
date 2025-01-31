import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/payment_method_widget.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/controllers/appointment_details_controller.dart';
import 'package:jappcare/features/workshop/ui/invoice/widgets/appointment_widget.dart';
import 'controllers/invoice_controller.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/widgets/invoices_widget.dart';

class InvoiceScreen extends GetView<InvoiceController> {
  final AppointmentDetailsController appointmentDetailsController =Get.put(AppointmentDetailsController(Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Invoice #001'),

        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Invoiced to',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ),
                      Row(

                        children: [
                          ClipRRect(
                            child: ImageComponent(
                              assetPath: AppImages.avatar,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'James May',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                'jamesmay@gmail.com',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF797676),
                                    fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: MediaQuery
                              .of(context)
                              .size
                              .width * .25,),

                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.red.withOpacity(.2)
                            ),
                            child: Text(
                              'Unpaid', style: TextStyle(color: AppColors
                                .red),),
                          )
                        ],
                      ),

                    ],
                  ),
                  AppointmentContainer(
                    vehiculName: '2024 Porsche Taycan',
                    vin: '89345643893',
                    from: "Japcare Autoshop",
                    service: "Body Shop Appointment",
                    caseId: "JC8586047",
                    issuedDate: "Oct 20, 2024",
                    dueDate: "Nov 20, 2024",
                  ),
                  InvoiceDetails(
                      items: appointmentDetailsController.invoiceItems,
                      total: 50500,
                      tax: 2500,
                      amount: 54000
                  ),
                  SizedBox(height: 20,),
                  Row(

                    children: [
                      CustomButton(
                          strech: false,
                          width: MediaQuery.of(context).size.width*.40,
                          haveBorder: true,
                          text: 'Review',
                          onPressed:(){
                            controller.showReviemModel();

                          } ),
                      SizedBox(width:10,),
                      CustomButton(
                        strech: false,
                          width: MediaQuery.of(context).size.width*.45,
                          text: 'Proceed Payment',
                          onPressed:(){
                              onpenModalPaymentMethod((){});
                          } ),
                    ],
                  )
                ],
              )
          ),
        )
    );
  }
}
void onpenModalPaymentMethod(void onConfirm) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true, // Permet un contrôle précis sur la hauteur
    backgroundColor: Colors.transparent, // Rendre l'arrière-plan transparent
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16), // Espacement intérieur
          child: Wrap(
            children: [
              PaymentMethodeWidget(onConfirm:(){
                onConfirm ;
              }),
            ],
          ),
        ),
      );
    },
  );
}
