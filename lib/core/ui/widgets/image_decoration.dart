import 'package:flutter/cupertino.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_constants.dart';

class ImageDecoration extends StatelessWidget{
  final String assetPath ;
  ImageDecoration({
        Key?key,
    required this.assetPath
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
      return Container(
        height: 266,
        width: 266,
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: Color(0xFFFFEDE6),
          borderRadius: BorderRadius.circular(200)
        ),
        child: ImageComponent(
          assetPath: assetPath,
        ),
      );
  }
  
}