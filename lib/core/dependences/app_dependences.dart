//Don't translate me
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../events/app_events_service.dart';
import '../navigation/app_navigation.dart';
import '../navigation/getx_navigation_impl.dart';
import '../navigation/routes/app_pages.dart';
import '../navigation/routes/app_routes.dart';
import '../services/localServices/get_storage_local_storage_service.dart';
import '../services/localServices/local_storage_service.dart';
import '../services/networkServices/dio_network_service.dart';
import '../services/networkServices/network_service.dart';

import '../../features/home/dependences/home_dependencies.dart';
import '../../features/home/navigation/private/home_pages.dart';

import '../../features/authentification/dependences/authentification_dependencies.dart';
import '../../features/authentification/navigation/private/authentification_pages.dart';

import '../../features/garage/dependences/garage_dependencies.dart';
import '../../features/garage/navigation/private/garage_pages.dart';

import '../../features/shop/dependences/shop_dependencies.dart';
import '../../features/shop/navigation/private/shop_pages.dart';

import '../../features/activities/dependences/activities_dependencies.dart';
import '../../features/activities/navigation/private/activities_pages.dart';

import '../../features/workshop/dependences/workshop_dependencies.dart';
import '../../features/workshop/navigation/private/workshop_pages.dart';

import '../../features/profile/dependences/profile_dependencies.dart';
import '../../features/profile/navigation/private/profile_pages.dart';

import '../../features/notifications/dependences/notifications_dependencies.dart';
import '../../features/notifications/navigation/private/notifications_pages.dart';

class AppDependency {
  static Future<void> init() async {
    // Initialize GetStorage
    await GetStorage.init();

    // initialize all pages
    final featuresPages = [
      NotificationsPages(),
      ProfilePages(),
      WorkshopPages(),
      ActivitiesPages(),
      ShopPages(),
      GaragePages(),
      AuthentificationPages(),
      HomePages(),
      //Add features pages here
    ];
    Get.lazyPut(() => AppPages(featuresPages), fenix: true);

    //initialize AppNavigation
    Get.lazyPut<AppNavigation>(() => GetXNavigationImpl(AppRoutes.notFoundPage),
        fenix: true);

    //initialize Views

    // Stockage local
    Get.lazyPut<LocalStorageService>(() => GetStorageService(), fenix: true);

    // Réseau
    final dioNetworkService = DioNetworkService();
    await dioNetworkService.init();
    Get.lazyPut<NetworkService>(() => dioNetworkService, fenix: true);

    // Events
    Get.lazyPut<AppEventService>(() => AppEventService(), fenix: true);

    //Chargement des dependances de features
    HomeDependencies.init();
    AuthentificationDependencies.init();
    GarageDependencies.init();
    ShopDependencies.init();
    ActivitiesDependencies.init();
    WorkshopDependencies.init();
    ProfileDependencies.init();
    NotificationsDependencies.init();
  }
}
