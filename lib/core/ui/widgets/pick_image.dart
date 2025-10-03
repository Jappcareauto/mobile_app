//Don't translate me
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/image_preview.screen.dart';

class PickImage extends StatelessWidget {
  PickImage({super.key, this.many = false, this.title});
  final bool many;
  final String? title;
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          // height: 80,
          width: Get.width,
          padding:
              const EdgeInsets.only(left: 8, right: 8, top: 14, bottom: 36),
          decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey : Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: Get.back, icon: Icon(Icons.close)),
                  Text(
                    title ?? "Image",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.camera,
                        );
                        if (pickedFile != null) {
                          print("Camera image path: ${pickedFile.path}");
                          // final result = await Get.to(
                          //     () => ImagePreviewScreen(imagePath: pickedFile.path));

                          Get.back(result: [File(pickedFile.path)]);

                          return;
                        } else {
                          Get.back();
                          return;
                        }
                        // Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 20,
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
                          const Text(
                            "Camera",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final pickedFile = many
                            ? await picker.pickMultiImage()
                            : await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                        print(pickedFile);

                        if (pickedFile != null) {
                          final result = pickedFile;

                          // final sendImage = await Get.to(
                          //     () => ImagePreviewScreen(imagePath: result.path));

                          if (many) {
                            Get.back(
                                result: (result as List<XFile>)
                                    .map((xFile) => File(xFile.path))
                                    .toList());
                          } else {
                            Get.back(result: [File((result as XFile).path)]);
                          }
                          // if (result != null) {
                          //   Get.back(result: [sendImage]);
                          // } else {
                          // }
                          return;
                        } 
                        // else if (pickedFile != null) {
                        //   List<File>? result = [];
                        //   for (var i in (pickedFile as List<XFile>)) {
                        //     final f = i;
                        //     result.add(File(f.path));
                        //   }
                        //   return Get.back(result: result);
                        // } 
                        else {
                          Get.back();
                        }
                      },
                      child: Row(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          const Text(
                            "Gallery",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     InkWell(
        //       onTap: () async {
        //         final pickedFile = await picker.pickImage(
        //           source: ImageSource.camera,
        //         );
        //         if (pickedFile != null) {
        //           final result = await Get.to(
        //               () => ImagePreviewScreen(imagePath: pickedFile.path));

        //           if (result != null) {
        //             Get.back(result: [result]);
        //           } else {
        //             Get.back();
        //           }
        //           return;
        //         }
        //         Get.back();
        //       },
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           CircleAvatar(
        //             backgroundColor: Get.theme.primaryColor,
        //             radius: 20,
        //             child: const Icon(
        //               Icons.camera_alt,
        //               color: Colors.white,
        //               size: 20,
        //             ),
        //           ),
        //           const Text("Camera")
        //         ],
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () async {
        //         final pickedFile = many
        //             ? await picker.pickMultiImage()
        //             : await picker.pickImage(
        //                 source: ImageSource.gallery,
        //               );
        //         print(pickedFile);

        //         if (pickedFile != null) {
        //           final result = pickedFile as XFile;

        //           final sendImage = await Get.to(
        //               () => ImagePreviewScreen(imagePath: result.path));

        //           if (sendImage != null) {
        //             Get.back(result: [sendImage]);
        //           } else {
        //             Get.back();
        //           }
        //           return;
        //         } else if (pickedFile != null && many) {
        //           List<File>? result = [];
        //           for (var i in (pickedFile as List<XFile>)) {
        //             final f = i;
        //             result.add(File(f.path));
        //           }
        //           return Get.back(result: result);
        //         } else {
        //           Get.back();
        //         }
        //       },
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           CircleAvatar(
        //             backgroundColor: Get.theme.primaryColor,
        //             radius: 20,
        //             child: const Icon(
        //               Icons.image,
        //               color: Colors.white,
        //               size: 20,
        //             ),
        //           ),
        //           const Text("Galerie")
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
