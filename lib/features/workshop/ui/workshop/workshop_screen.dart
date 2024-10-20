import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import 'controllers/workshop_controller.dart';
import 'package:get/get.dart';

import 'widgets/categories_item_list.dart';

class WorkshopScreen extends GetView<WorkshopController>
    implements FeatureWidgetInterface {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Workshop"),
        body: Container(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomFormField(
                    hintText: "Search Centers",
                    prefix: Icon(FluentIcons.search_24_regular),
                  ),
                ),
                SizedBox(height: 20),
                CategoriesItemList(),
                const SizedBox(height: 20),
            ],
          ),
        ));
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
