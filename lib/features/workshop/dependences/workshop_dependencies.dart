import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/workshop/workshop_screen.dart';
import '../../../core/ui/interfaces/feature_widget_interface.dart';
import '../domain/repositories/workshop_repository.dart';
import '../infrastructure/repositoriesImpl/workshop_repository_impl.dart';

class WorkshopDependencies {
  static void init() {
    Get.lazyPut<WorkshopRepository>(
        () => WorkshopRepositoryImpl(networkService: Get.find()),
        fenix: true);
    Get.lazyPut<FeatureWidgetInterface>(() => WorkshopScreen(),
        tag: 'WorkshopScreen', fenix: true);
  }
}
