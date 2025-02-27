import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/shop/ui/shop/widgets/product_list-shimmer.dart';
import 'package:jappcare/features/shop/ui/shop/widgets/tabs_list_widgets.dart';
import 'controllers/shop_controller.dart';
import 'package:get/get.dart';

class ShopScreen extends GetView<ShopController>
    implements FeatureWidgetInterface {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShopController(Get.find()));
    return Scaffold(
        appBar: CustomAppBar(
          title: "Shop",
          actions: [
            InkWell(
              onTap: () {},
              child: const Icon(
                FluentIcons.shopping_bag_16_regular,
                size: 40,
              ),
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
                  TabsListWidgets(
                      tabs: controller.categorie,
                      selectedFilter: controller.selectedFilter,
                      selectedTabs: controller.selectedCategory,
                      borderRadius: BorderRadius.circular(16),
                      haveBorder: true),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Obx(
              () => controller.loading.value
                  ? const SliverToBoxAdapter(
                      child: ShimmerProduct(),
                    )
                  : controller.products.value!.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              'Aucun produit pour le moment',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      : SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 300,
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final product = controller.products.value![index];
                              return GestureDetector(
                                onTap: () {
                                  controller.goToProductDetails(
                                    product.id,
                                    product.name,
                                    product.description,
                                    product.price.amount,
                                  );
                                },
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 190,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            border: Border.all(
                                                width: 1,
                                                color: const Color.fromARGB(
                                                    255, 231, 231, 231)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            child: ImageComponent(
                                              imageUrl: (product
                                                      .media.items.isNotEmpty)
                                                  ? product
                                                      .media.items[0].sourceUrl
                                                  : null,
                                              assetPath: (product
                                                      .media.items.isNotEmpty)
                                                  ? product
                                                      .media.items[0].sourceUrl
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            product.name,
                                            overflow: TextOverflow.visible,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            "${NumberFormat('#,###.##').format(product.price.amount)} ${product.price.currency}",
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
                            childCount: controller.products.value!.length,
                          ),
                        ),
            )
          ],
        )

        // CustomScrollView(
        //   slivers: [
        //     SliverToBoxAdapter(
        //       child: Column(
        //         children: [
        //           const Padding(
        //             padding: EdgeInsets.symmetric(horizontal: 20),
        //             child: CustomFormField(
        //               hintText: "Search Centers",
        //               prefix: Icon(FluentIcons.search_24_regular),
        //             ),
        //           ),
        //           const SizedBox(height: 20),
        //           TabsListWidgets(
        //               tabs: controller.categorie,
        //               selectedFilter: controller.selectedFilter,
        //               selectedTabs: controller.selectedCategory ,
        //               borderRadius: BorderRadius.circular(16),
        //               haveBorder: true
        //           ),
        //           SizedBox(height: 20),
        //         ],
        //       ),
        //     ),
        //     Obx(() =>
        //
        //         SliverGrid(
        //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //             mainAxisExtent: 300,
        //             crossAxisCount: 2,
        //             crossAxisSpacing: 0,
        //             mainAxisSpacing: 2,
        //           ),
        //           delegate: SliverChildBuilderDelegate(
        //                 (context, index) {
        //               final product = controller.filteredParts[index];
        //               controller.loading.value ?
        //               SliverToBoxAdapter(
        //                   child: ShimmerProduct()
        //               ):
        //               controller.products.value!.isEmpty ?
        //               SliverToBoxAdapter(
        //                   child: Center(
        //                     child:
        //                     Text('Aucun produit pour le moment'),
        //
        //                   )
        //               ) :
        //                GestureDetector(
        //                 onTap: () {
        //                   // controller.goToProductDetails(
        //                   //   product.id
        //                   // );
        //                 },
        //                 child: Card(
        //                   color: Colors.transparent,
        //                   elevation: 0,
        //                   child: Container(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Container(
        //                           width: double.infinity,
        //                           height: 190,
        //                           decoration: BoxDecoration(
        //                             borderRadius:
        //                             const BorderRadius.all(Radius.circular(15)),
        //                             border: Border.all(
        //                                 width: 1,
        //                                 color:
        //                                 const Color.fromARGB(255, 231, 231, 231)),
        //                           ),
        //                           child: ClipRRect(
        //                             borderRadius: BorderRadius.circular(16.0),
        //                             child:
        //                             ImageComponent(
        //                                 imageUrl: product.media.items[0].sourceUrl,
        //                                 assetPath: product.media.items[0].sourceUrl),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.only(top: 8),
        //                           child: Text(
        //                            product.name,
        //                             overflow: TextOverflow.visible,
        //                             style: const TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 16,
        //                             ),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding:
        //                           const EdgeInsets.symmetric(horizontal: 8.0),
        //                           child: Text(
        //                             "${NumberFormat('#,###').format(int.parse(product.price.amount.toString()))}" "${product.price.currency}",
        //                             style: TextStyle(
        //                               color: Get.theme.primaryColor,
        //                               fontSize: 14,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             },
        //             childCount: controller.filteredParts.length,
        //           ),
        //         ),
        //     )
        //
        //   ],
        // ),
        );
  }

  @override
  Widget buildView([args]) {
    return this;
  }

  @override
  void refreshData() {
    // TODO: implement refreshData
  }
}
