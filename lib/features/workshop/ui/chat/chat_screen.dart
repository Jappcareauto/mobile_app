import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/chat_input_widget.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/payment_method_widget.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/resume_appointment_widget.dart';

import 'controllers/chat_controller.dart';
import 'widgets/chat_app_bar.dart';
// import 'widgets/chat_input_field.dart';
import 'widgets/chat_message.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends GetView<ChatController> {
  final BookAppointmentController bookController =
      Get.put(BookAppointmentController(Get.find()));
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();

  ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Get.theme.secondaryHeaderColor,
      appBar: const ChatAppBar(
        profileImageUrl: AppImages.avatar,
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
                      ? Colors.black.withValues(alpha: .9)
                      : Colors.white,
                ),
                child: ClipRRect(
                  child: ListView(
                    reverse: false,
                    padding: const EdgeInsets.all(12.0),
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                              'This is the biginning of your conversation with Japcare AutoShop',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .6),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              if (Get.isRegistered<FeatureWidgetInterface>(
                                  tag: 'AvatarWidget'))
                                Get.find<FeatureWidgetInterface>(
                                        tag: 'AvatarWidget')
                                    .buildView({"haveName": true}),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  Get.find<ProfileController>()
                                          .userInfos
                                          ?.name ??
                                      "Unknow",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() => ResumeAppointmentWidget(
                          services: globalControllerWorkshop
                              .workshopData['serviceCenterName'],
                          date: globalControllerWorkshop
                              .workshopData['selectedDate'],
                          caseId: globalControllerWorkshop
                              .workshopData['appointmentId'],
                          note: globalControllerWorkshop
                              .workshopData['noteController'],
                          fee: '5,000 Frs',
                          time: globalControllerWorkshop
                              .workshopData['selectedTime'])),
                      const SizedBox(
                        height: 20,
                      ),

                      ..._.messages.map((message) {
                        return SingleChildScrollView(
                            controller: controller.scrollController,
                            child: ChatMessage(
                              text: message
                                  .content, // Utilise une chaîne vide si "text" est null
                              isSender: message.senderId ==
                                      Get.find<ProfileController>()
                                          .userInfos
                                          ?.id
                                  ? true
                                  : false, // Valeur par défaut pour "isSender"
                            ));
                      }),

                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            // CircleAvatar(
                            //
                            //   backgroundImage: AssetImage(AppImages.avatar),
                            // ),
                            SizedBox(width: 5),

                            // Text('Japtech AutoShop'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // InvoiceCard(
                      //   name: "Sara May",
                      //   email: "jamesmay@gmail.com",
                      //   service: "Inspection Fee",
                      //   invoiceNumber: "JC564739300",
                      //   dateIssued: "Oct 20, 2024",
                      //   amount: "7,000 Frs",
                      //   status: "Pending",
                      //   onViewInvoice: () {
                      //     // Action pour voir la facture
                      //     print("View Invoice clicked");
                      //    onpenModalPaymentMethod(controller.goToAddPaymentMethodForm);
                      //   },
                      // ),
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
                    onAttach: () {},
                    onMic: () {},
                  )),
            ],
          );
        },
      ),
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
                color: Colors.black.withValues(alpha: .1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16), // Espacement intérieur
          child: Wrap(
            children: [
              PaymentMethodeWidget(onConfirm: () {
                onConfirm;
              }),
            ],
          ),
        ),
      );
    },
  );
}
