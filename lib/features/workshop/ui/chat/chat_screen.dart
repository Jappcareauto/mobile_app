import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/chat_input_widget.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/chat_invoice.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/resume_appointment_widget.dart';

import 'controllers/chat_controller.dart';
import 'widgets/chat_app_bar.dart';
import 'widgets/chat_input_field.dart';
import 'widgets/chat_message.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends GetView<ChatController> {
  final BookAppointmentController bookController = Get.put(BookAppointmentController(Get.find()));

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Get.theme.secondaryHeaderColor,
      appBar:  ChatAppBar(

        profileImageUrl:AppImages.avatar ,
        username: "Sara",

      ),
      body: MixinBuilder<ChatController>(
        initState: (_) {},
        builder: (_) {
          return Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.black.withOpacity(.9)
                        : Colors.white,

                   ),
                child: ClipRRect(

                  child: ListView(
                    reverse: false,
                    padding: const EdgeInsets.all(12.0),
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        child:  Align(

                          alignment: Alignment.center,
                          child:
                          Text('This is the biginning of your conversation with Japcare AutoShop' , style:TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal, color:  Colors.grey)),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*.7
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(

                            children: [
                              Text('Sara'),
                              SizedBox(width: 5,),
                              CircleAvatar(

                                backgroundImage: AssetImage(AppImages.avatar),
                              )
                            ],
                          ),
                        ) ,
                      ),

                      SizedBox(height: 20,),
                      Obx(() =>
                          ResumeAppointmentWidget(
                              services: 'Body Shop Appointment',
                              vehicule: 'Posche Taycan Turbo S',
                              date: bookController.selectedDate.value,
                              note: 'I would like to fix a dent front bumper',
                              fee: '5,000 Frs',
                              time: bookController.selectedTime.value
                          )
                      )
                     ,
                    SizedBox(height: 20,),

                      ..._.messages.map((message) {
                        return ChatMessage(
                          text: message["text"],

                          isSender: message["isSender"],
                          images: message["images"],
                        );
                      }),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(

                          children: [
                            SizedBox(width: 5,),
                            CircleAvatar(

                              backgroundImage: AssetImage(AppImages.avatar),
                            ),
                            const SizedBox(width:5),

                            Text('Japtech AutoShop'),

                          ],
                        ),
                      ) ,
                      const SizedBox(height: 10),

                      InvoiceCard(
                        name: "Sara May",
                        email: "jamesmay@gmail.com",
                        service: "Inspection Fee",
                        invoiceNumber: "JC564739300",
                        dateIssued: "Oct 20, 2024",
                        amount: "7,000 Frs",
                        status: "Pending",
                        onViewInvoice: () {
                          // Action pour voir la facture
                          print("View Invoice clicked");
                          controller.onpenModalPaymentMethod();
                        },
                      ),
                      const SizedBox(height: 100),

                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: ChatInputWidget(
                    chatController: controller ,
                    onAttach: (){},
                    onMic: (){},
                  )),
            ],
          );
        },
      ),
    );
  }
}