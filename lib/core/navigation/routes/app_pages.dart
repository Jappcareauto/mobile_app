import 'package:get/get.dart';
import '../../ui/screens/notFoundScreen/not_found_screen.dart';
import '../../ui/screens/splashScreen/splash_screen.dart';
import '../bindings/splash_controller_binding.dart';
import 'app_routes.dart';
import 'features_pages.dart';

class AppPages {
  final List<FeaturePages> features;

  AppPages(this.features);

  List<GetPage> getAllPages() {
    List<GetPage> allPages = [];
    for (var feature in features) {
      allPages.addAll(feature.getPages());
    }

    // Ajout d'une route 404 par défaut
    allPages.add(GetPage(
        name: AppRoutes.notFoundPage, page: () => const NotFoundScreen()));
    allPages.add(GetPage(
        name: AppRoutes.splash,
        page: () => const SplashScreen(),
        binding: SplashControllerBinding()));

    return allPages;
  }
}