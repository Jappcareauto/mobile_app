import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../../core/utils/app_images.dart';
import 'car_card_add_vehicle.dart';
import 'car_container_widget.dart';
import 'shimmers/garage_name_shimmer.dart';
import 'shimmers/list_vehicle_shimmer.dart';

class ListVehicleWidget extends StatelessWidget
    implements FeatureWidgetInterface {
  final bool haveTitle;
  final PageController? pageController;
  final RxInt? currentPage;
  final bool? haveAddVehicule;
  final String title;
  final VoidCallback? onTapeAddVehicle;

  final Function(int index)? onSelected;
  final int? selectedIndex;
  const ListVehicleWidget(
      {super.key,
         this.pageController,
         this.currentPage,
         this.haveAddVehicule = true,
        this.onTapeAddVehicle,

      this.haveTitle = true,
      this.title = "My Garage",
      this.onSelected,
      this.selectedIndex});

  @override
  Widget build(BuildContext context) {

    return MixinBuilder<GarageController>(
      init: GarageController(Get.find(),Get.find()),
      autoRemove: false,
      initState: (_) {},
      builder: (_) {
        print("vehicleList");

        print(_.vehicleList);
        return Obx((){
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (haveTitle)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _.loading.value
                      ? const MyGarageNameShimmer()
                      : Text(title,
                      style: Get.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
              if (haveTitle) const SizedBox(height: 5),
              _.loading.value
                  ? const ListVehicleShimmer()
                  : SizedBox(
                height: 190,
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                child:PageView.builder(
                    controller: pageController,
                    itemCount: _.vehicleList.length + (haveAddVehicule == true ? 1 : 0), // Ajouter un élément si nécessaire
                    onPageChanged: (index) {
                      currentPage?.value = index; // Mettre à jour la page actuelle
                    },
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (haveAddVehicule == true && index == _.vehicleList.length) {
                        return GestureDetector(
                          onTap: _.goToAddVehicle,
                          child: Container(
                            height: 200,
                            margin: const EdgeInsets.only(right: 12),
                            width: 360,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Get.theme.primaryColor.withOpacity(.1),
                              border: Border.all(
                                color: Get.theme.primaryColor.withOpacity(.1),
                                width: 3,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '+ Add Vehicle',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        );
                      }
                      return Obx(() {
                        return CarCardAddVehicle(
                          key: ValueKey(_.vehicleList[index]),
                          haveBGColor:  false,
                          hideblure: true,
                          haveBorder: currentPage?.value == index,
                          containerheight: 200,
                          next: () {
                            if (index == _.vehicleList.length - 1 && !haveAddVehicule! ) {
                              pageController?.jumpToPage(0);
                            } else {
                              pageController?.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          carName:  _.vehicleList[index].name?? '',
                          carDetails:  _.vehicleList[index].vin ?? '',
                          imagePath:  _.vehicleList[index].imageUrl ?? '',
                          imageUrl:  _.vehicleList[index].imageUrl ?? '',
                        );
                      });
                    }

                ) ,
          )

              ),
            ],
          );
        });

      },
    );
  }

  @override
  Widget buildView([args]) {
    return ListVehicleWidget(
      pageController: args["pageController"],
      currentPage: args["currentPage"],
      haveAddVehicule: args["haveAddVehicule"],
      onTapeAddVehicle: args["onTapeAddVehicle"],
      title: args["title"],

    );
  }

}
