import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/features/garage/application/usecases/get_place_name_use_case.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/garage/ui/garage/garage_screen.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/list_veehicle_widget.dart';

import '../domain/repositories/garage_repository.dart';
import '../infrastructure/repositoriesImpl/garage_repository_impl.dart';
import '../ui/garage/widgets/recent_activities_widget.dart';

import '../application/usecases/get_garage_by_owner_id_usecase.dart';

import '../application/usecases/get_vehicle_list_usecase.dart';

import '../application/usecases/add_vehicle_usecase.dart';

class GarageDependencies {
  static void init() {
    Get.lazyPut<GarageRepository>(
        () => GarageRepositoryImpl(networkService: Get.find()),
        fenix: true);
    Get.lazyPut<FeatureWidgetInterface>(() =>  ListVehicleWidget(),
        tag: 'ListVehicleWidget', fenix: true);
    Get.lazyPut<FeatureWidgetInterface>(() => const GarageScreen(),
        tag: 'GarageScreen', fenix: true);
    //RecentActivitiesWidget
    Get.lazyPut<FeatureWidgetInterface>(
        () =>  RecentActivitiesWidget(haveTabBar: false),
        tag: 'RecentActivitiesWidget',
        fenix: true);
    Get.lazyPut(() => GetGarageByOwnerIdUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetVehicleListUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => AddVehicleUseCase(Get.find()), fenix: true);
    Get.put(GarageController(Get.find(),Get.find()), permanent: true);
    Get.lazyPut(() => GetPlaceNameUseCase(Get.find()), fenix: true);

}}
