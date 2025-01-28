import '../../../features/home/navigation/home_public_routes.dart';
import '../../../features/error/navigation/error_public_routes.dart';
  
import '../../../features/vehicleFinder/navigation/vehicle_finder_public_routes.dart';
  
import '../../../features/emergency/navigation/emergency_public_routes.dart';
  
import '../../../features/services/navigation/services_public_routes.dart';
  
import '../../../features/chat/navigation/chat_public_routes.dart';
  
import '../../../features/notifications/navigation/notifications_public_routes.dart';
  
import '../../../features/profile/navigation/profile_public_routes.dart';
  
import '../../../features/workshop/navigation/workshop_public_routes.dart';
  
import '../../../features/activities/navigation/activities_public_routes.dart';
  
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
  // static const generateVehicleReport = GaragePublicRoutes.generateVehicleReport;
  //Shop Public Routes
  static const shop = ShopPublicRoutes.home;
  //Activities Public Routes
  static const activities = ActivitiesPublicRoutes.home;
  //Workshop Public Routes
  static const workshop = WorkshopPublicRoutes.home;
  static const workshopchat = WorkshopPublicRoutes.chat;

  //Profile Public Routes
  static const profile = ProfilePublicRoutes.home;
  //Notifications Public Routes
  static const notifications = NotificationsPublicRoutes.home;
  //Chat Public Routes
  static const chat = ChatPublicRoutes.home;
  //Services Public Routes
  static const services = ServicesPublicRoutes.home;
  static const generateVehicleReport = ServicesPublicRoutes.generateVehiculeReport;

  //Emergency Public Routes
  static const emergency = EmergencyPublicRoutes.home;

  //VehicleFinder Public Routes
  static const vehicleFinder = VehicleFinderPublicRoutes.home;
  //Error Public Routes
  static const error = ErrorPublicRoutes.home;
  static const commingSoon = ErrorPublicRoutes.commingSoon;
  static const netWorkError = ErrorPublicRoutes.networkError;


}