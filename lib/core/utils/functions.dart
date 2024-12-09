import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/pick_image.dart';
Future<List<File>?> getImage({bool many = false}) {
  return showModalBottomSheet<List<File>?>(
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (BuildContext context) {
        return PickImage(
          many: many,
        );
      });
}