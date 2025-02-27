import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessage extends StatelessWidget {
  final String? text;
  final bool isSender;

  final List<File>? images;

  const ChatMessage({
    super.key,
    this.text,
    required this.isSender,

     this.images,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(

          crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isSender
                    ? Get.theme.primaryColor.withOpacity(0.2)
                    : isDarkMode
                    ? Get.theme.scaffoldBackgroundColor.withOpacity(0.2)
                    : Colors.grey.shade200,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16))
                    .copyWith(
                    bottomLeft: isSender
                        ? const Radius.circular(16)
                        : null,
                    bottomRight: isSender
                        ? null
                        : const Radius.circular(16)),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (text != null)
                    Text(
                      text!,
                      style: TextStyle(
                        color: isSender || isDarkMode
                            ? Colors.black
                            : Colors.black,
                      ),
                    ),


                ],
              ),
            ),
            if (images != null)
              Wrap(
                spacing: 2.0,
                runSpacing: 2.0,
                children: images!.map((imagePath) {
                  final imageFile = File(imagePath.path);
                  return Image.file(
                    imageFile ,
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}