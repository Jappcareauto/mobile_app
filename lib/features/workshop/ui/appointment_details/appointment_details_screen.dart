import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/chip_widget.dart';
import 'package:jappcare/features/home/ui/home/widgets/notification_widget.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/controllers/appointment_details_controller.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/widgets/expendend_container_widget.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/widgets/invoices_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class AppointmentDetailScreen extends GetView<AppointmentDetailsController> {
  final BookAppointmentController bookController =
      Get.put(BookAppointmentController(Get.find()));

  AppointmentDetailScreen({super.key});
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (appointment.vehicle?.imageUrl != null)
                ImageComponent(
                  // assetPath: AppImages.carWhite,
                  imageUrl: appointment.vehicle?.imageUrl,
                ),
              NotificationWidget(
                  backgrounColor: Get.theme.primaryColor.withValues(alpha: .2),
                  bodyText:
                      'Your repair from the Japcare Autotech shop is ready, and available for pickup',
                  coloriage: Get.theme.primaryColor,
                  icon: FluentIcons.alert_12_regular,
                  title: 'Notification'),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 20,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage(AppImages.avatar),
                      ),
                      SizedBox(width: 5),
                      Text('Japtech AutoShop'),
                    ],
                  ),
                  Flexible(
                      child:
                          ChipWidget(status: appointment.status ?? "Unknown")),
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
                    "${appointment.service?.description}",
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
              Row(children: [
                const Icon(
                  FluentIcons.calendar_3_day_20_regular,
                ),
                Text(
                  DateFormat('EEE, MMM dd, yyyy')
                      .format(DateTime.parse(appointment.date)),
                  // Format personnalisé
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 40),
                const Icon(
                  FluentIcons.location_12_regular,
                ),
                Text(appointment.locationType,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300))
              ]),
              const SizedBox(
                height: 20,
              ),
              ExpandableContainer(
                onpresse: () => controller.toggleExpanded(),
                visibility: controller.isExpanded,
                subtitle: const Text(
                  "Reported Issue",
                  style: TextStyle(
                      fontSize: 14.0, height: 1.5, color: Colors.grey),
                ),
                title: "Reported Issue",
                description:
                    "There is a noticeable dent on the rear bumper of my Porsche Taycan, specifically located between the lower edge of the rear headlight and the rear wheel arch. It is closer to the wheel arch, situated near the car's side profile. The dent is below the horizontal line of the rear headlight and sits closer to the lower third of the rear bumper.",
                imageUrls: bookController.images,
                controller: controller,
              ),
              const SizedBox(
                height: 20,
              ),
              ExpandableContainer(
                onpresse: () {
                  controller.toggleisExpandedReportDetail();
                },
                visibility: controller.isExpandedReportDetail,
                subtitle: Text("Diagnosed Issue & Repairs to be made",
                    style: TextStyle(color: Get.theme.primaryColor)),
                title: "Reported Details",
                description:
                    "There is a noticeable dent on the rear bumper of my Porsche Taycan, specifically located between the lower edge of the rear headlight and the rear wheel arch. It is closer to the wheel arch, situated near the car's side profile. The dent is below the horizontal line of the rear headlight and sits closer to the lower third of the rear bumper.",
                imageUrls: const [],
                controller: controller,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Visibility(
                  visible: controller.isExpandedReportDetail.value,
                  child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.withValues(alpha: .2),
                              width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Repaire made',
                            style: TextStyle(color: Get.theme.primaryColor),
                          ),
                          const Text(
                              'We fixed the rear bumper by hammering out the dent, and applied a new coat of body paint protection. ')
                        ],
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InvoiceDetails(
                  items: controller.invoiceItems,
                  total: 50500,
                  tax: 2500,
                  amount: 54000),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: 'Pay Invoice',
                  onPressed: () {
                    controller.goToInvoice();
                  }),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
