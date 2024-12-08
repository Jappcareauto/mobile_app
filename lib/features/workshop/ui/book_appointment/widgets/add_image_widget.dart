import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class AddImageWidget extends GetView<BookAppointmentController>{
  @override
  Widget build(BuildContext context) {
     return Container(
       margin: EdgeInsets.all(20),

       child: Column(
         children: [
           Row(
             children: [
               Text('Add Images' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
             ],
           ),
           SizedBox(height: 20,),
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child:  Obx(
                   () => Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   // Affiche les autres containers uniquement si la liste n'est pas vide
                   ...controller.images.map((imagePath) {
                     return Container(
                       margin: EdgeInsets.only(right: 20), // Espacement entre les images
                       height: 100,
                       width: MediaQuery.of(context).size.width * 0.25,
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(20),
                         child: Image.asset(
                           imagePath,
                           fit: BoxFit.cover,
                         ),
                       ),
                     );
                   }).toList(),
                   // Conteneur par défaut (toujours présent)

                   GestureDetector(
                     onTap: (){
                       print('Pick photo');
                     },
                     child: Container(
                       height: 100,
                       width: MediaQuery.of(context).size.width * 0.25,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Get.theme.primaryColor.withOpacity(0.2), // Couleur par défaut
                       ),
                       child: Center(
                         child: Icon(
                           FluentIcons.add_24_filled,
                           color: Get.theme.primaryColor,
                         ),
                       ),
                     ),
                   ),

                   SizedBox(width: 20),
                 ],
               ),
             )
           )
         ],
       ),
     );

  }

}