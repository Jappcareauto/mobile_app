import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';

class ImageGallerry extends StatelessWidget{
  @override
  final Iterable<dynamic> images ;
  final String title ;
  ImageGallerry({
    Key?key,
    required this.images,
    required this.title
}):super(key: key);
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10 , bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111111)),)
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(

                  children: [
                    ...images.map((image) {
                      return Row(
                        children: [
                          SizedBox(width: 8,),
                          Container(
                              height: 100,
                              width: 100,
                              child:
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ImageComponent(
                                  assetPath: image,
                                ),
                              )
                          )
                        ],
                      );
                    }).toList(),

                  ]
              ),
            ),
          ],
        )

    );
  }
  
}