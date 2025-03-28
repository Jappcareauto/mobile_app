import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';
import '../../../../core/ui/interfaces/feature_widget_interface.dart';
import 'controllers/onboarding_controller.dart';
import 'package:get/get.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<OnboardingController>(
      initState: (_) {},
      builder: (controller) {
        Widget buildDot(int index, BuildContext context) {
          return Container(
            height: 10,
            width: controller.currentPage.value == index ? 18 : 10,
            margin: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(AppDimensions.radiusExtraLarge),
              color: controller.currentPage.value == index
                  ? Colors.white
                  : Colors.white60,
            ),
          );
        }

        return Scaffold(
            backgroundColor: Get.theme.primaryColor,
            // floatingActionButton: _.currentPage == 2
            //     ? null
            //     : FloatingActionButton(
            //         shape: const CircleBorder(),
            //         elevation: 0,
            //         backgroundColor: Colors.black,
            //         onPressed: () {
            //           if (_.currentPage < 2) {
            //             _.pageController.nextPage(
            //               duration: const Duration(milliseconds: 300),
            //               curve: Curves.easeIn,
            //             );
            //           } else {
            //             // Naviguer vers l'écran principal
            //           }
            //         },
            //         child: Icon(
            //           FluentIcons.arrow_right_32_regular,
            //           color: _.currentPage == 2 ? Colors.black : Colors.white,
            //         ),
            //       ),
            appBar: AppBar(
              backgroundColor: Get.theme.primaryColor,
              automaticallyImplyLeading: false,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChange,
                    children: [
                      // Container(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Expanded(
                      //         child: Padding(
                      //           padding: EdgeInsets.only(left: 10, top: 30),
                      //           child: Text(
                      //             "Jappcare\nAutoTech",
                      //             style:
                      //                 TextStyle(fontSize: 45, color: Colors.white),
                      //           ),
                      //         ),
                      //       ),
                      //       const Expanded(
                      //         flex: 2,
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.end,
                      //           children: [
                      //             ImageComponent(
                      //               assetPath: AppImages.car1,
                      //               height: 250,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Expanded(
                      //         child: Padding(
                      //           padding: EdgeInsets.only(
                      //               left: AppDimensions.paddingMedium),
                      //           child: Container(
                      //             //color: Colors.red,
                      //             // Vous pouvez utiliser un `SizedBox` pour contrôler la taille si nécessaire
                      //             child: const Text(
                      //               "Your one\nstop for all \nyour vehicle\nneeds",
                      //               style: TextStyle(
                      //                   fontSize: 45, color: Colors.white),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       const Expanded(
                      //         flex: 2,
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: [
                      //             ImageComponent(
                      //               assetPath: AppImages.car2,
                      //               height: 250,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Get.isRegistered<FeatureWidgetInterface>(
                              tag: "AuthentificationScreen")
                          ? Get.find<FeatureWidgetInterface>(
                                  tag: "AuthentificationScreen")
                              .buildView()
                          : const Center(
                              child: Text(
                                  "Le module authentification est abscent"),
                            )
                    ],
                  ),
                  Positioned(
                    right: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                          List.generate(3, (index) => buildDot(index, context)),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
