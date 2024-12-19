import 'package:get/get.dart';

import '../bindings/vehicul_report_controller_binding.dart';
import '../../ui/vehiculReport/vehicul_report_screen.dart';

import '../bindings/generatingsuccess_controller_binding.dart';
import '../../ui/generatingsuccess/generatingsuccess_screen.dart';

import '../bindings/generating_loading_controller_binding.dart';
import '../../ui/generatingLoading/generating_loading_screen.dart';

import '../bindings/oder_detail_controller_binding.dart';
import '../../ui/oderDetail/oder_detail_screen.dart';

import '../bindings/add_vehicle_controller_binding.dart';
import '../../ui/addVehicle/add_vehicle_screen.dart';

import '../bindings/generate_vehicule_report_controller_binding.dart';
import '../../ui/generateVehiculeReport/generate_vehicule_report_screen.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/services/services_screen.dart';
import '../bindings/services_controller_binding.dart';
import 'services_private_routes.dart';

class ServicesPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: ServicesPrivateRoutes.home,
      page: () => ServicesScreen(),
      binding: ServicesControllerBinding(),
    ),
    GetPage(
      name: ServicesPrivateRoutes.generateVehiculeReport,
      page: () => GenerateVehiculeReportScreen(),
      binding: GenerateVehiculeReportControllerBinding(),
    ),
    GetPage(
      name: ServicesPrivateRoutes.addVehicle,
      page: () => AddVehicleScreen(),
      binding: AddVehicleControllerBinding(),
    ),
    GetPage(
      name: ServicesPrivateRoutes.oderDetail,
      page: () => OderDetailScreen(),
      binding: OderDetailControllerBinding(),
    ),
    GetPage(
      name: ServicesPrivateRoutes.generatingLoading,
      page: () => GeneratingLoadingScreen(),
      binding: GeneratingLoadingControllerBinding(),
    ),
    GetPage(
      name: ServicesPrivateRoutes.generatingsuccess,
      page: () => GeneratingsuccessScreen(),
      binding: GeneratingsuccessControllerBinding(),
    ),
    GetPage(
      name: ServicesPrivateRoutes.vehiculReport,
      page: () => VehiculReportScreen(),
      binding: VehiculReportControllerBinding(),
    ),
    // Add other routes here
  ];
}
