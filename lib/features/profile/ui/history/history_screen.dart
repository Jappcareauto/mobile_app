import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'controllers/history_controller.dart';
import 'package:get/get.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "History"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (Get.isRegistered<FeatureWidgetInterface>(
                  tag: 'RecentActivitiesWidget'))
                Get.find<FeatureWidgetInterface>(tag: 'RecentActivitiesWidget')
                    .buildView(true),
              const SizedBox(height: 100),
            ],
          ),
        ));
  }
}
