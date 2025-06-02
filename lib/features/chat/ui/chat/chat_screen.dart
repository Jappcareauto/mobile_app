import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/utils/app_colors.dart';
// import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_controller.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/chat_list_tile.widget.dart';
// import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
// import 'package:jappcare/features/workshop/ui/chat/controllers/workshop_chat_controller.dart';
// import 'package:jappcare/features/workshop/ui/chat/widgets/chat_app_bar.dart';
// import 'package:jappcare/features/workshop/ui/chat/widgets/chat_input_widget.dart';
// import 'package:jappcare/features/workshop/ui/chat/widgets/chat_invoice.dart';
// import 'package:jappcare/features/workshop/ui/chat/widgets/payment_method_widget.dart';
// import 'package:jappcare/features/workshop/ui/workshop/widgets/workshop_shimmer_widgets.dart';

// import 'controllers/chat_controller.dart';
// import 'widgets/chat_app_bar.dart';
// import 'widgets/chat_input_field.dart';
// import 'widgets/chat_message.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatScreen extends GetView<ChatController> {
  // final BookAppointmentController bookController =
  //     Get.put(BookAppointmentController(Get.find()));

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        appBarcolor: Get.theme.scaffoldBackgroundColor,
        title: "Messages",
        canBack: true,
        actions: [
          if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
        ],
      ),
      body: GetBuilder<ChatController>(
        init: ChatController(Get.find()),
        initState: (_) {},
        builder: (controller) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: controller.messageSearchFormHelper.formKey,
                    autovalidateMode: controller
                        .messageSearchFormHelper.autovalidateMode.value,
                    child: CustomFormField(
                      controller: controller
                          .messageSearchFormHelper.controllers['name'],
                      borderRadius: 32,
                      filColor: AppColors.primary,
                      hintText: "Search",
                      prefix: const Icon(FluentIcons.search_24_regular),
                      validator:
                          controller.messageSearchFormHelper.validators['name'],
                    ),
                  ),
                ),

                // Chat List
                Expanded(
                  child: Obx(() {
                    if (controller.loading.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final chats = controller.filteredChats;

                    if (chats.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No chats found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: controller.refreshChats,
                      child: ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          return ChatListTile(
                            chat: chat,
                            onTap: () => controller.goToChat(chat),
                          );
                        },
                      ),
                    );
                  }),
                ),

                // const SizedBox(
                //     // height: 300, // Hauteur fixée
                //     child: SingleChildScrollView(
                //   child: Column(
                //     children: [
                //       WorkshopShimmerWidgets(),
                //       WorkshopShimmerWidgets(),
                //     ],
                //   ),
                // )),
              ]);
          // return Stack(
          //   children: [
          //     Container(
          //       width: Get.width,
          //       height: Get.height,
          //       decoration: BoxDecoration(
          //         color: isDarkMode
          //             ? Colors.black.withValues(alpha: .9)
          //             : Colors.white,
          //       ),
          //       child: ClipRRect(
          //         child: ListView(
          //           reverse: false,
          //           padding: const EdgeInsets.all(12.0),
          //           children: [
          //             Container(
          //               margin: EdgeInsets.all(20),
          //               child: Align(
          //                 alignment: Alignment.center,
          //                 child: Text(
          //                     'This is the biginning of your conversation with Japcare AutoShop',
          //                     style: TextStyle(
          //                         fontSize: 12,
          //                         fontWeight: FontWeight.normal,
          //                         color: Colors.grey)),
          //               ),
          //             ),

          //             Container(
          //               margin: EdgeInsets.only(
          //                   left: MediaQuery.of(context).size.width * .6),
          //               child: Align(
          //                 alignment: Alignment.topRight,
          //                 child: Row(
          //                   children: [
          //                     if (Get.isRegistered<FeatureWidgetInterface>(
          //                         tag: 'AvatarWidget'))
          //                       Get.find<FeatureWidgetInterface>(
          //                               tag: 'AvatarWidget')
          //                           .buildView({"haveName": true}),
          //                     SizedBox(
          //                       width: 10,
          //                     ),
          //                     Text(
          //                         Get.find<ProfileController>()
          //                                 .userInfos
          //                                 ?.name ??
          //                             "Unknow",
          //                         style: TextStyle(
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.bold))
          //                   ],
          //                 ),
          //               ),
          //             ),

          //             SizedBox(
          //               height: 20,
          //             ),
          //             // Obx(() => ResumeAppointmentWidget(
          //             //     services: Get.arguments['serviceName'],
          //             //     date: bookController.selectedDate.value,
          //             //     caseId: bookController.vehicleVin.value,
          //             //     note: bookController.noteController.text,
          //             //     fee: '5,000 Frs',
          //             //     time: bookController.selectedTime.value)),
          //             SizedBox(
          //               height: 20,
          //             ),

          //             ...controller.messages.map((message) {
          //               return SingleChildScrollView(
          //                   controller: controller.scrollController,
          //                   child: ChatMessage(
          //                     text: message
          //                         .content, // Utilise une chaîne vide si "text" est null
          //                     isSender: message.senderId ==
          //                             Get.find<ProfileController>()
          //                                 .userInfos
          //                                 ?.id
          //                         ? true
          //                         : false, // Valeur par défaut pour "isSender"
          //                   ));
          //             }),

          //             const SizedBox(height: 20),
          //             Align(
          //               alignment: Alignment.topRight,
          //               child: Row(
          //                 children: [
          //                   SizedBox(
          //                     width: 5,
          //                   ),
          //                   // CircleAvatar(
          //                   //
          //                   //   backgroundImage: AssetImage(AppImages.avatar),
          //                   // ),
          //                   const SizedBox(width: 5),

          //                   // Text('Japtech AutoShop'),
          //                 ],
          //               ),
          //             ),
          //             const SizedBox(height: 10),

          //             // InvoiceCard(
          //             //   name: "Sara May",
          //             //   email: "jamesmay@gmail.com",
          //             //   service: "Inspection Fee",
          //             //   invoiceNumber: "JC564739300",
          //             //   dateIssued: "Oct 20, 2024",
          //             //   amount: "7,000 Frs",
          //             //   status: "Pending",
          //             //   onViewInvoice: () {
          //             //     // Action pour voir la facture
          //             //     print("View Invoice clicked");
          //             //    onpenModalPaymentMethod(controller.goToAddPaymentMethodForm);
          //             //   },
          //             // ),
          //             const SizedBox(height: 100),
          //           ],
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //         bottom: 0,
          //         right: 0,
          //         left: 0,
          //         child: ChatInputWidget(
          //           onAttach: () {},
          //           onMic: () {},
          //         )),
          //   ],
          // );
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
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16), // Espacement intérieur
          child: Wrap(
            children: [
              // PaymentMethodeWidget(onConfirm: () {
              //   onConfirm;
              // }),
            ],
          ),
        ),
      );
    },
  );
}
