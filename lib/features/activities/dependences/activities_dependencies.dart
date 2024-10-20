import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/features/activities/ui/activities/activities_screen.dart';

import '../domain/repositories/activities_repository.dart';
import '../infrastructure/repositoriesImpl/activities_repository_impl.dart';

class ActivitiesDependencies {
  static void init() {
    Get.lazyPut<ActivitiesRepository>(
        () => ActivitiesRepositoryImpl(networkService: Get.find()),
        fenix: true);

    Get.lazyPut<FeatureWidgetInterface>(() => ActivitiesScreen(),
        tag: "ActivitiesScreen", fenix: true);
  }
}
