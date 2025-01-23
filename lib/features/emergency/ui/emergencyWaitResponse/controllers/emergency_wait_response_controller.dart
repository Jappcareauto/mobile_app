import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/networkServices/dio_network_service.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/emergency/application/usecases/declined_emergency_command.dart';
import 'package:jappcare/features/emergency/application/usecases/declined_emergency_usecase.dart';
import 'package:jappcare/features/emergency/domain/core/exceptions/emergency_exception.dart';
import 'package:jappcare/features/emergency/domain/entities/declined_emergency.dart';
import 'package:jappcare/features/emergency/infrastructure/models/declined_emergency_model.dart';
import 'package:jappcare/features/emergency/navigation/private/emergency_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class EmergencyWaitResponseController extends GetxController {
  final AppNavigation _appNavigation;
  EmergencyWaitResponseController(this._appNavigation);
  var loading = false.obs ;
  final DeclinedEmergencyUsecase declinedEmergencyUsecase   = DeclinedEmergencyUsecase(Get.find());
  var isExpanded = true.obs ;
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
  void processChat(){
    _appNavigation.toNamed(AppRoutes.workshopchat);
  }
  Future<void> declinedEmergency (String id , String status) async {
    loading.value = true ;
      final result = await declinedEmergencyUsecase.call(DeclinedEmergencyCommand(
          id: id,
          status: status)
      );
      result.fold((e){
        Get.showCustomSnackBar(e.message);
        loading.value = false ;
      }, (success){
        _appNavigation.toNamed(EmergencyPrivateRoutes.emergencyDetail);
        loading.value = true ;
        print(result);
      });
  }
}
