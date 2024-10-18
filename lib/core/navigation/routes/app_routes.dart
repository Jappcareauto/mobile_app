import '../../../features/home/navigation/home_public_routes.dart';
import '../../../features/shop/navigation/shop_public_routes.dart';
  
import '../../../features/garage/navigation/garage_public_routes.dart';
  
import '../../../features/authentification/navigation/authentification_public_routes.dart';
  
  
import '../../utils/app_constants.dart';

class AppRoutes {
  static String get initialRoute => splash;
  
  static const splash = AppConstants.splashScreen;
  static const notFoundPage = AppConstants.notFoundScreen;
  //Home Public Routes
  static const home = HomePublicRoutes.home;
  //Authentification Public Routes
  static const authentification = AuthentificationPublicRoutes.home;
  //Garage Public Routes
  static const garage = GaragePublicRoutes.home;
  //Shop Public Routes
  static const shop = ShopPublicRoutes.home;
}