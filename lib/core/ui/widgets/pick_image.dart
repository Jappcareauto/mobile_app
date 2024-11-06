//Don't translate me
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatelessWidget {
  PickImage({Key? key, this.many = false}) : super(key: key);
  final bool many;
  final picker = ImagePicker();

  File parseImage(String parent, String path) {
    File imagePath = File(path);
    var image = decodeImage(imagePath.readAsBytesSync());
    return File(
        '$parent/img_${DateTime.now().toString().replaceAll(' ', '')}.jpg')
      ..writeAsBytesSync(encodeJpg(image!));
  }

  Future<Size> getSizeImage(File file) async {
    var decodedImage = await decodeImageFromList(file.readAsBytesSync());
    return Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 80,
      width: Get.width,
      decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              final pickedFile = await picker.pickImage(
                source: ImageSource.camera,
              );
              if (pickedFile != null) {
                final result = pickedFile;
                Get.back(result: [result]);
                return;
              }
              Get.back();
            },
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Get.theme.primaryColor,
                  radius: 20,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const Text("Camera")
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              final pickedFile = many
                  ? await picker.pickMultiImage()
                  : await picker.pickImage(
                      source: ImageSource.gallery,
                    );

              if (pickedFile != null && !many) {
                final result = pickedFile as XFile;
                return Get.back(result: [File(result.path)]);
              } else if (pickedFile != null && many) {
                List<File>? result = [];
                for (var i in (pickedFile as List<XFile>)) {
                  final f = i;
                  result.add(File(f.path));
                }
                return Get.back(result: result);
              } else {
                Get.back();
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Get.theme.primaryColor,
                  radius: 20,
                  child: const Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const Text("Galerie")
              ],
            ),
          ),
        ],
      ),
    );
  }
}