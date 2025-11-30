import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/pick_image.dart';

Future<List<File>?> getImage({bool many = false, bool withPreview = false}) {
  return Get.bottomSheet<List<File>?>(
      PickImage(
        many: many,
        withPreview: withPreview,
      ),
      backgroundColor: Colors.transparent, // Rendre l'arrière-plan transparent
      enableDrag: false,
      isScrollControlled: true, // Permet un contrôle précis sur la hauteur
  );
}
