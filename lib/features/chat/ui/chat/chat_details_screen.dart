// import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:jappcare/core/utils/app_images.dart';
// import 'package:jappcare/features/chat/ui/chat/widgets/chat_input_widget.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/chat_appointment_summary.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/image_message_widget.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/payment_method_widget.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/chat_app_bar.dart';
// import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/profile/ui/profile/widgets/avatar_widget.dart';
// import 'package:jappcare/features/chat/ui/chat/widgets/chat_invoice.dart';

// import 'controllers/chat_controller.dart';
// import 'widgets/chat_app_bar.dart';
// import 'widgets/chat_input_field.dart';
import 'widgets/chat_message_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends GetView<ChatDetailsController> {
  // final BookAppointmentController bookController =
  //     Get.put(BookAppointmentController(Get.find()));

  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: ChatAppBar(
        profileImageUrl: AppImages.avatar,
        username: controller.appointment.serviceCenter?.name ?? '',
      ),
      body: GetBuilder<ChatDetailsController>(
        initState: (_) {},
        builder: (controller) {
          return SafeArea(
              child: Column(
            children: [
              Flexible(
                child: ListView(
                  controller: controller.scrollController,
                  reverse: false,
                  padding: const EdgeInsets.all(12.0),
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'This is the beginning of your conversation with Jappcare AutoShop',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 5,
                            children: [
                              Text(controller.currentUser?.name ?? 'Unknown'),
                              AvatarWidget(size: 40, canEdit: false)

                              // CircleAvatar(
                              //   backgroundImage: CachedNetworkImageProvider(controller.currentUser?.image ?? '',
                              //     placeholder: (context, url) => _buildShimmer(),
                              //     errorWidget: (context, url, error) => _buildDefaultImage(),
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        ChatAppointmentSummary(),
                      ],
                    ),
                    SizedBox(height: 20),
                    Obx(() {
                      if (controller.loading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        spacing: 20,
                        children: [
                          // Column(
                          //   spacing: 10,
                          //   children: [
                          //     Align(
                          //       alignment: Alignment.topRight,
                          //       child: Row(
                          //         children: [
                          //           SizedBox(
                          //             width: 5,
                          //           ),
                          //           CircleAvatar(
                          //             backgroundImage:
                          //                 AssetImage(AppImages.avatar),
                          //           ),
                          //           const SizedBox(width: 5),
                          //           Text('Japtech AutoShop'),
                          //         ],
                          //       ),
                          //     ),
                          //     InvoiceCard(
                          //       name: "Sara May",
                          //       email: "Body Shop Appointment",
                          //       service: "Inspection Fee",
                          //       invoiceNumber: "JC564739300",
                          //       dateIssued: "Oct 20, 2024",
                          //       amount: "7,000 Frs",
                          //       status: "Pending",
                          //       onViewInvoice: () {
                          //         // Action pour voir la facture
                          //         print("View Invoice clicked");
                          //         onpenModalPaymentMethod(
                          //             controller.goToAddPaymentMethodForm);
                          //       },
                          //     ),
                          //   ],
                          // ),

                          ...controller.groupedMessages.keys.map((key) {
                            final messages = controller.groupedMessages[key]!;
                            return Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Get.theme.primaryColor.withValues(
                                        alpha: 0.6,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Text(
                                      key,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ...messages.map((message) {
                                // print(
                                //     "message: ${message.content}, isImageMessage: ${message.isImageMessage} ${message.toJson()}");
                                return message.isImageMessage
                                    ? ImageMessageWidget(
                                        message: message,
                                      )
                                    : ChatMessageWidget(
                                        message:
                                            message, // Utilise une chaîne vide si "text" est null
                                      );
                              }),
                            ]);
                          }),
                        ],
                      );
                    }),

                    // Container(
                    //   margin: EdgeInsets.only(
                    //       left: MediaQuery.of(context).size.width * .6),
                    //   child: Align(
                    //     alignment: Alignment.topRight,
                    //     child: Row(
                    //       children: [
                    //         if (Get.isRegistered<FeatureWidgetInterface>(
                    //             tag: 'AvatarWidget'))
                    //           Get.find<FeatureWidgetInterface>(
                    //                   tag: 'AvatarWidget')
                    //               .buildView({"haveName": true}),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //             Get.find<ProfileController>()
                    //                     .userInfos
                    //                     ?.name ??
                    //                 "Unknow",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold))
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // Obx(() => ResumeAppointmentWidget(
                    //     services: Get.arguments['serviceName'],
                    //     date: bookController.selectedDate.value,
                    //     caseId: bookController.vehicleVin.value,
                    //     note: bookController.noteController.text,
                    //     fee: '5,000 Frs',
                    //     time: bookController.selectedTime.value)),
                    // SizedBox(
                    //   height: 20,
                    // ),

                    // ...controller.groupedMessages.entries.map((entry) {
                    //   final messages = entry.value;
                    //   final isSender = messages.first.senderId ==
                    //           Get.find<ProfileController>().userInfos?.id
                    //       ? true
                    //       : false;
                    //   return ChatDateWidget(
                    //     date: entry.key,
                    //     isSender: isSender,
                    //   );

                    // final isSender = message.senderId ==
                    //         Get.find<ProfileController>().userInfos?.id
                    //     ? true
                    //     : false;
                    // return message.isImageMessage
                    //     ? ImageMessageWidget(
                    //         message: message,
                    //         isMyMessage: isSender,
                    //       )
                    //     : ChatMessageWidget(
                    //         text: message
                    //             .content, // Utilise une chaîne vide si "text" est null
                    //         isSender:
                    //             isSender, // Valeur par défaut pour "isSender"
                    //       );
                    // }),

                    // Obx(() => controller.isLoading.value
                    //     ? const Center(
                    //         child: CircularProgressIndicator(),
                    //       )
                    //     : const SizedBox.shrink()),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
              const Divider(
                height: 1.0,
              ),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ));
        },
      ),
    );
  }

  /// Builds the text input composer widget at the bottom of the screen.
  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Get.theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 8,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEDE6), // Couleur d'arrière-plan rosé
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  // Flexible text field
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      onSubmitted: controller.handSentTextMessage,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Write a message',
                      ),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Image picker button
                  IconButton(
                    icon: const Icon(Icons.photo_library),
                    onPressed: controller.pickImage,
                  ),
                ],
              ),
            ),
          ),

          // Send button
          GestureDetector(
            onTap: () => controller
                .handSentTextMessage(controller.messageController.text),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.primaryColor, // Couleur du bouton d'envoi
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),

          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 4.0),
          //   child: IconButton(
          //     icon: const Icon(Icons.send),
          //     onPressed: () => ,
          //   ),
          // ),
        ],
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
                color: Colors.black.withValues(alpha: 0.1),
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


// Stack(
//               children: [
//                 // Container(
//                 //   width: Get.width,
//                 //   height: Get.height,
//                 //   decoration: BoxDecoration(
//                 //       color: isDarkMode
//                 //           ? Colors.black.withValues(alpha: .9)
//                 //           : Get.theme.scaffoldBackgroundColor
//                 //       // : Colors.white,
//                 //       ),
//                   // child: 
//                   Flexible(
//                     child: ListView(
//                       controller: controller.scrollController,
//                       reverse: false,
//                       padding: const EdgeInsets.all(12.0),
//                       children: [
//                         Container(
//                           margin: EdgeInsets.all(20),
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               'This is the beginning of your conversation with Jappcare AutoShop',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           spacing: 10,
//                           children: [
//                             Align(
//                               alignment: Alignment.topRight,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 spacing: 5,
//                                 children: [
//                                   Text(controller.currentUser?.name ?? 'Unknown'),
//                                   AvatarWidget(size: 40, canEdit: false)
                                  
//                                   // CircleAvatar(
//                                   //   backgroundImage: CachedNetworkImageProvider(controller.currentUser?.image ?? '',
//                                   //     placeholder: (context, url) => _buildShimmer(),
//                                   //     errorWidget: (context, url, error) => _buildDefaultImage(),
//                                   //     fit: BoxFit.cover,
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                             ChatAppointmentSummary(),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         Obx(() {
//                           if (controller.loading.value) {
//                             return Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           }
//                           return Column(
//                             spacing: 20,
//                             children: [
//                               // Column(
//                               //   spacing: 10,
//                               //   children: [
//                               //     Align(
//                               //       alignment: Alignment.topRight,
//                               //       child: Row(
//                               //         children: [
//                               //           SizedBox(
//                               //             width: 5,
//                               //           ),
//                               //           CircleAvatar(
//                               //             backgroundImage:
//                               //                 AssetImage(AppImages.avatar),
//                               //           ),
//                               //           const SizedBox(width: 5),
//                               //           Text('Japtech AutoShop'),
//                               //         ],
//                               //       ),
//                               //     ),
//                               //     InvoiceCard(
//                               //       name: "Sara May",
//                               //       email: "Body Shop Appointment",
//                               //       service: "Inspection Fee",
//                               //       invoiceNumber: "JC564739300",
//                               //       dateIssued: "Oct 20, 2024",
//                               //       amount: "7,000 Frs",
//                               //       status: "Pending",
//                               //       onViewInvoice: () {
//                               //         // Action pour voir la facture
//                               //         print("View Invoice clicked");
//                               //         onpenModalPaymentMethod(
//                               //             controller.goToAddPaymentMethodForm);
//                               //       },
//                               //     ),
//                               //   ],
//                               // ),
                    
//                               ...controller.groupedMessages.keys.map((key) {
//                                 final messages =
//                                     controller.groupedMessages[key]!;
//                                 return Column(children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         margin:
//                                             const EdgeInsets.only(bottom: 10),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10, vertical: 5),
//                                         decoration: BoxDecoration(
//                                           color:
//                                               Get.theme.primaryColor.withValues(
//                                             alpha: 0.6,
//                                           ),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10)),
//                                         ),
//                                         child: Text(
//                                           key,
//                                           style: const TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   ...messages.map((message) {
//                                     // print(
//                                     //     "message: ${message.content}, isImageMessage: ${message.isImageMessage} ${message.toJson()}");
//                                     return message.isImageMessage
//                                         ? ImageMessageWidget(
//                                             message: message,
//                                           )
//                                         : ChatMessageWidget(
//                                             message:
//                                                 message, // Utilise une chaîne vide si "text" est null
//                                           );
//                                   }),
//                                 ]);
//                               }),
//                             ],
//                           );
//                         }),
                    
//                         // Container(
//                         //   margin: EdgeInsets.only(
//                         //       left: MediaQuery.of(context).size.width * .6),
//                         //   child: Align(
//                         //     alignment: Alignment.topRight,
//                         //     child: Row(
//                         //       children: [
//                         //         if (Get.isRegistered<FeatureWidgetInterface>(
//                         //             tag: 'AvatarWidget'))
//                         //           Get.find<FeatureWidgetInterface>(
//                         //                   tag: 'AvatarWidget')
//                         //               .buildView({"haveName": true}),
//                         //         SizedBox(
//                         //           width: 10,
//                         //         ),
//                         //         Text(
//                         //             Get.find<ProfileController>()
//                         //                     .userInfos
//                         //                     ?.name ??
//                         //                 "Unknow",
//                         //             style: TextStyle(
//                         //                 fontSize: 16,
//                         //                 fontWeight: FontWeight.bold))
//                         //       ],
//                         //     ),
//                         //   ),
//                         // ),
                    
//                         // Obx(() => ResumeAppointmentWidget(
//                         //     services: Get.arguments['serviceName'],
//                         //     date: bookController.selectedDate.value,
//                         //     caseId: bookController.vehicleVin.value,
//                         //     note: bookController.noteController.text,
//                         //     fee: '5,000 Frs',
//                         //     time: bookController.selectedTime.value)),
//                         // SizedBox(
//                         //   height: 20,
//                         // ),
                    
//                         // ...controller.groupedMessages.entries.map((entry) {
//                         //   final messages = entry.value;
//                         //   final isSender = messages.first.senderId ==
//                         //           Get.find<ProfileController>().userInfos?.id
//                         //       ? true
//                         //       : false;
//                         //   return ChatDateWidget(
//                         //     date: entry.key,
//                         //     isSender: isSender,
//                         //   );
                    
//                         // final isSender = message.senderId ==
//                         //         Get.find<ProfileController>().userInfos?.id
//                         //     ? true
//                         //     : false;
//                         // return message.isImageMessage
//                         //     ? ImageMessageWidget(
//                         //         message: message,
//                         //         isMyMessage: isSender,
//                         //       )
//                         //     : ChatMessageWidget(
//                         //         text: message
//                         //             .content, // Utilise une chaîne vide si "text" est null
//                         //         isSender:
//                         //             isSender, // Valeur par défaut pour "isSender"
//                         //       );
//                         // }),
                    
//                         // Obx(() => controller.isLoading.value
//                         //     ? const Center(
//                         //         child: CircularProgressIndicator(),
//                         //       )
//                         //     : const SizedBox.shrink()),
                    
//                         const SizedBox(height: 100),
//                       ],
//                     ),
//                   ),
//                 // ),
//                 Positioned(
//                     bottom: 0,
//                     right: 0,
//                     left: 0,
//                     child: ChatInputWidget(
//                       onAttach: () {},
//                       onMic: () {},
//                       chatController: controller,
//                     )),
//               ],
//             ),