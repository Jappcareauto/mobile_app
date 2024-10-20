import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/workshop/workshop_screen.dart';
import '../../../core/ui/interfaces/feature_widget_interface.dart';
import '../domain/repositories/workshop_repository.dart';
import '../infrastructure/repositoriesImpl/workshop_repository_impl.dart';
import '../ui/workshop/widgets/categories_item_list.dart';

class WorkshopDependencies {
  static void init() {
    Get.lazyPut<WorkshopRepository>(
        () => WorkshopRepositoryImpl(networkService: Get.find()),
        fenix: true);
    Get.lazyPut<FeatureWidgetInterface>(() => WorkshopScreen(),
        tag: 'WorkshopScreen', fenix: true);
    Get.lazyPut<FeatureWidgetInterface>(() => CategoriesItemList(),
        tag: 'CategoriesItemList', fenix: true);
  }
}
