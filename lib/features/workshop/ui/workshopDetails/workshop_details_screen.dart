import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/views/workshop_custom_map_view.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/widgets/text_shimmer.dart';
import '../widgets/workshop_carrousel.dart';
import '../workshop/widgets/categories_item_list.dart';
import 'controllers/workshop_details_controller.dart';
import 'package:get/get.dart';

class WorkshopDetailsScreen extends GetView<WorkshopDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ImageCarousel(
                        imageUrls: const [
                          AppImages.shopCar,
                          AppImages.carWhite,
                          AppImages.shopCar
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 45, left: 20),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_back  , color: Colors.black,),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                           controller.arguments['name'],
                            style: Get.textTheme.headlineLarge,
                          ),
                          Chip(
                            backgroundColor: const Color(0xFFC4FFCD),
                            label: const Text(
                              'Available',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600),
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0, color: Color(0xFFC4FFCD)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.place_outlined,
                                color: Get.theme.primaryColor,
                              ),
                              SizedBox(width: 5),
                              Obx(() =>
                              controller.loading.value ?
                                  TextShimmer() :
                                  Text(
                                    controller.placeName.value,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Get.theme.primaryColor,
                                    ),
                                  )
                              )

                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 5),
                            child: const Text(
                              '|',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.star_rounded,
                                  color: Colors
                                      .orange), // Utiliser une couleur appropriée
                              Text('4.5',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child:  Text(
                    controller.arguments['description'],
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                const SelectServiceItemList(title: 'Specialized Services'),
                const SizedBox(height: 20),
                SizedBox(
                    height: 300,
                    child: const WorkshopCustomMapView()),
                SizedBox(height: 20),

                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    text: 'Book Appointment',
                    onPressed: () {
                      controller.gotoBoockApontment();
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),

          ),

    );
  }



}
