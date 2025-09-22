import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/chip_widget.dart';
import 'package:jappcare/features/home/ui/home/widgets/notification_widget.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/controllers/appointment_details_controller.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/widgets/expendend_container_widget.dart';
// import 'package:jappcare/features/workshop/ui/appointment_details/widgets/invoices_widget.dart';
// import 'package:jappcare/features/workshop/ui/book_appointment/widgets/chat_widget.dart';
// import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class AppointmentDetailScreen extends GetView<AppointmentDetailsController> {
  // final BookAppointmentController bookController =
  //     Get.put(BookAppointmentController(Get.find()));

  const AppointmentDetailScreen({super.key});
  // final ConfirmeAppointmentController confirmAppointment = Get.put(ConfirmeAppointmentController(Get.find()));
  @override
  Widget build(BuildContext context) {
    final appointment = controller.appointment;
    return Scaffold(
      appBar: CustomAppBar(
        appBarcolor: Get.theme.scaffoldBackgroundColor,
        title: 'Appointment\nDetails',
        actions: [
          if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${appointment.vehicle?.detail?.make} ${appointment.vehicle?.detail?.model}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  color: Get.theme.primaryColor)),
                          Text("${appointment.vehicle?.detail?.year}"),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (appointment.vehicle?.imageUrl != null)
                        Container(
                          width: Get.width,
                          height: 200,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            border:
                                Border.all(width: 1, color: Color(0XFFE5E2E1)),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16), // same radius as the container
                            child: ImageComponent(
                              // assetPath: AppImages.carWhite,
                              imageUrl: appointment.vehicle?.imageUrl,
                              width: Get.width * .85,
                              height: 200,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (controller.appointment.status == 'COMPLETED') ...[
                        NotificationWidget(
                            backgroundColor:
                                Get.theme.primaryColor.withValues(alpha: .2),
                            bodyText:
                                'Your repair from the Japcare Autotech shop is ready, and available for pickup',
                            coloriage: Get.theme.primaryColor,
                            icon: FluentIcons.alert_12_regular,
                            title: 'Notification'),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 20,
                        children: [
                          Row(
                            spacing: 5,
                            children: [
                              controller.appointment.serviceCenter != null && controller.appointment.serviceCenter?.imageUrl != null ?
                              ImageComponent(
                                imageUrl: "",
                                width: 60,
                                height: 60,
                                borderRadius: 100,
                              )
                               : Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Get.theme.primaryColor, width: 2)),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.black,
                                  radius: 25,
                                  child: Text(
                                    controller.appointment.serviceCenter?.name?[0]
                                            .toUpperCase() ??
                                        '',
                                    style: Get.textTheme.headlineLarge?.copyWith(
                                        color: Get.theme.primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                              ,
                              Text(
                                controller.appointment.serviceCenter?.name ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                          Flexible(
                              child: ChipWidget(
                                  status: appointment.status ?? "Unknown")),
                          // Container(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(30),
                          //       color: Get.theme.primaryColor.withValues(alpha: .2)),
                          //   child: Text(
                          //     'In Progress',
                          //     style: TextStyle(color: Get.theme.primaryColor),
                          //   ),
                          // )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${appointment.service?.title.replaceAll("_", " ")} Appointment",
                            style: TextStyle(
                                color: AppColors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 2.5,
                            children: [
                              const Icon(
                                FluentIcons.calendar_12_regular,
                                color: Color(0XFF797676),
                              ),
                              Text(
                                DateFormat('EEE, MMM dd, yyyy')
                                    .format(DateTime.parse(appointment.date)),
                                // Format personnalisé
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0XFF797676),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 2.5,
                            children: [
                              const Icon(
                                FluentIcons.location_12_regular,
                                color: Color(0XFF797676),
                              ),
                              Text(appointment.formattedLocationType,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0XFF797676),
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // ExpandableContainer(
                      //   onpresse: () => controller.toggleExpanded(),
                      //   visibility: controller.isExpanded,
                      //   subtitle: const Text(
                      //     "Reported Issue",
                      //     style: TextStyle(
                      //         fontSize: 14.0, height: 1.5, color: Colors.grey),
                      //   ),
                      //   title: "Reported Issue",
                      //   description:
                      //       "There is a noticeable dent on the rear bumper of my Porsche Taycan, specifically located between the lower edge of the rear headlight and the rear wheel arch. It is closer to the wheel arch, situated near the car's side profile. The dent is below the horizontal line of the rear headlight and sits closer to the lower third of the rear bumper.",
                      //   imageUrls: bookController.images,
                      //   controller: controller,
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      if (controller.appointment.diagnosesToMake != null &&
                          controller.appointment.diagnosesToMake!.isNotEmpty)
                        ExpandableContainer(
                          onExpand: () {
                            controller.toggleisExpandedReportDetail();
                          },
                          visibility: controller.isExpandedReportDetail,
                          subtitle: Text("Diagnosed Issue & Repairs to be made",
                              style: TextStyle(color: Get.theme.primaryColor)),
                          title: "Reported Details",
                          description:
                              controller.appointment.diagnosesToMake ?? "",
                          imageUrls: const [],
                          controller: controller,
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.isExpandedReportDetail.value &&
                              controller.appointment.diagnosesMade != null &&
                              controller.appointment.diagnosesMade!.isNotEmpty,
                          child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.withValues(alpha: .2),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Repairs made',
                                    style:
                                        TextStyle(color: Get.theme.primaryColor),
                                  ),
                                  Text(
                                      controller.appointment.diagnosesMade ?? ""),
                                ],
                              )),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // InvoiceDetails(
                      //     items: controller.invoiceItems,
                      //     total: 50500,
                      //     tax: 2500,
                      //     amount: 54000),
                      const SizedBox(
                        height: 10,
                      ),
                      if (controller.appointment.status == 'NOT_STARTED') ...[
                        CustomButton(
                            text: 'Pay Invoice',
                            onPressed: () {
                              controller.goToInvoice();
                            }),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                      if (controller.appointment.status == 'IN_PROGRESS') ...[
                        CustomButton(text: 'Mark as completed', onPressed: () {}),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ]),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Get.theme.primaryColor,
                onPressed: () => controller.goToChatScreen(),
                child: Icon(
                  FluentIcons.chat_16_regular,
                  color: Get.theme.scaffoldBackgroundColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
