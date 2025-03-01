import 'package:flutter/cupertino.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';

class ImageDecoration extends StatelessWidget {
  final String assetPath;
  const ImageDecoration({super.key, required this.assetPath});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: const Color(0xFFFFEDE6),
          borderRadius: BorderRadius.circular(200)),
      child: ImageComponent(
        assetPath: assetPath,
      ),
    );
  }
}
