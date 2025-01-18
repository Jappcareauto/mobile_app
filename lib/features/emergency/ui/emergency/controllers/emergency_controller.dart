import 'package:get/get.dart';
import 'package:jappcare/features/emergency/application/usecases/emergency_command.dart';
import 'package:jappcare/features/emergency/application/usecases/emergency_usecase.dart';
import 'package:jappcare/features/emergency/domain/entities/emergency.dart';
import 'package:jappcare/features/emergency/navigation/private/emergency_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';



import '../../../../../core/utils/getx_extensions.dart';


class EmergencyController extends GetxController {
  final EmergencyUseCase _emergencyUseCase = Get.find();

  final loading = false.obs;



  final Location location  = Get.find();
  final AppNavigation _appNavigation;
  EmergencyController(this._appNavigation);
  List<String> categorie = ['Tow my vehicle' , 'Break Failure' , 'Flat Tire' , 'Engine not starting' , 'Electrical Fault' , 'Other'] ;
  var selectedCategorie = ''.obs ;
  var selectedindex = 0.obs ;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }
  void goToEmergencyDetail(){
    _appNavigation.toNamed(EmergencyPrivateRoutes.emergencyDetail);
  }

  void goBack(){
    _appNavigation.goBack();
  }


  Future<void> emergencyAssistance() async {
    loading.value = true;
    final result = await _emergencyUseCase.call(
      EmergencyCommand(
          serviceCenterId: "serviceCenterId",
          vehicleId: "vehicleId",
          title: "title",
          note: "note",
          status: "status",
          location: location,
          id: "id",
          createdAt: "createdAt",
          updatedAt: "updatedAt",
          createdBy: "createdBy",
          updatedBy: "updatedBy"
      )
    );
    result.fold(
      (e) {
         loading.value = false;
         if(Get.context !=null)
            Get.showCustomSnackBar(e.message);
      },
      (response) {
        loading.value = false;
        print(response);
      },
    );
  }



}
