import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/categories_item_list.dart';
import 'controllers/shop_controller.dart';
import 'package:get/get.dart';

class ShopScreen extends GetView<ShopController>
    implements FeatureWidgetInterface {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShopController(Get.find()));
    return Scaffold(
      appBar:  CustomAppBar(
          title: "Shop",
          actions: [
              InkWell(
                onTap : (){},
                child: Icon(FluentIcons.shopping_bag_16_regular , size: 40,),
              )
          ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomFormField(
                    hintText: "Search Centers",
                    prefix: Icon(FluentIcons.search_24_regular),
                  ),
                ),
                const SizedBox(height: 20),
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child:  Row(
                     children: List.generate(controller.categorie.length, (index){
                         return Obx((){
                           final category = controller.categorie[index];
                           return GestureDetector(
                             onTap: (){
                               controller.selectedFilter.value = index ;
                               controller.selectedCategory.value = category ;
                             },
                             child: Container(

                               margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),


                               decoration: BoxDecoration(
                                 color: Color(0xFFFFEDE6),
                                 border: Border.all(color:  controller.selectedFilter.value == index
                                     ? Color(0xFFFB7C37)
                                     : Color(0xFFFFEDE6) , width: 1.5),
                                 borderRadius: BorderRadius.circular(16),
                               ),
                               child: Center(
                                 child: Text(
                                   controller.categorie[index],
                                   style: TextStyle(
                                     fontSize: 16,
                                     color:Colors.black,
                                   ),
                                 ),
                               ),
                             ),
                           );
                         });
                       }),


                 ),
               )

              ],
            ),
          ),
          Obx(() {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 300,
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final part = controller.filteredParts[index];
                  return GestureDetector(
                    onTap: () {
                      controller.goToProductDetails(
                          part['name'],
                          part['price'],
                          part['imagePath'],
                          part['description']
                      );
                    },
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 190,
                              decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    width: 1,
                                    color:
                                    const Color.fromARGB(255, 231, 231, 231)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child:
                                ImageComponent(assetPath: part['imagePath']),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                part['name'],
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${NumberFormat('#,###').format(int.parse(part['price']))} Frs",
                                style: TextStyle(
                                  color: Get.theme.primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: controller.filteredParts.length,
              ),
            );
          })

        ],
      ),
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
