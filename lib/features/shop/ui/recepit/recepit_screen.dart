import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/shop/ui/odersummary2/controllers/odersummary2_controller.dart';
import 'package:jappcare/features/shop/ui/odersummary2/widgets/items_widgets.dart';
import 'controllers/recepit_controller.dart';
import 'package:get/get.dart';

class RecepitScreen extends GetView<RecepitController> {
  final Odersummary2Controller _odersummary2controller =
      Get.put(Odersummary2Controller(Get.find()));

  RecepitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Completed'),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
            child: Column(children: [
              const ImageComponent(assetPath: AppImages.confirmTransaction),
              const Text(
                'Success',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                "${NumberFormat('#,###').format(_odersummary2controller.totalPrice)} Frs",
                style: const TextStyle(
                    color: AppColors.orange,
                    fontWeight: FontWeight.w700,
                    fontSize: 22),
              ),
              ItemsWidgets(),
              const SizedBox(
                height: 50,
              )
            ]),
          )),
        ));
  }
}
