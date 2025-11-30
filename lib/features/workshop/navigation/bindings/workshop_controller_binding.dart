import 'package:get/get.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import '../../ui/workshop/controllers/workshop_controller.dart';

// The role of the binding is to link the controller to the view
// The Binding class is a class that will decouple dependency injection, while "binding" routes to the state manager and dependency manager.
// This allows Get to know which screen is being displayed when a particular controller is used and to know where and how to dispose of it.
class WorkshopControllerBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut is use to lazyLoad dependencies (classes) so that it will be instanciated only when it is used.
    // This is very useful for computational expensive classes or if you want to instantiate several classes in just one place (like in a Bindings class) and you know you will not gonna use that class at that time.

    if (!Get.isRegistered<GlobalcontrollerWorkshop>()) {
      Get.lazyPut<GlobalcontrollerWorkshop>(() => GlobalcontrollerWorkshop(),
          fenix: true);
    }
    Get.lazyPut<WorkshopController>(() => WorkshopController(Get.find()));
  }
}
