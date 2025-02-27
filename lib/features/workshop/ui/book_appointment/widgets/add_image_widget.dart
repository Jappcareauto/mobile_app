import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class AddImageWidget extends GetView<BookAppointmentController>{
  const AddImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
       margin: const EdgeInsets.all(20),

       child: Column(
         children: [
           const Row(
             children: [
               Text('Add Images' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
             ],
           ),
           const SizedBox(height: 20,),
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child:  Obx(
                   () => Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   // Affiche les autres containers uniquement si la liste n'est pas vide
                   ...controller.selectedImages.map((imagePath) {
                     return Container(
                       margin: const EdgeInsets.only(right: 20), // Espacement entre les images
                       height: 100,
                       width: MediaQuery.of(context).size.width * 0.25,
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(20),
                         child:Image.file(
                           imagePath, // Ajuster la taille de l'image
                           fit: BoxFit.cover,
                         ),
                       ),
                     );
                   }),
                   // Conteneur par défaut (toujours présent)

                   GestureDetector(
                     onTap: (){
                       print('Pick photo');
                       controller.selectImagesFromGallery();
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

                   const SizedBox(width: 20),
                 ],
               ),
             )
           )
         ],
       ),
     );

  }

}