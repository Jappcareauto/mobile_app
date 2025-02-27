import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/emergency/application/usecases/emergency_command.dart';
import 'package:jappcare/features/emergency/application/usecases/emergency_usecase.dart';
import 'package:jappcare/features/emergency/domain/entities/emergency.dart';
import 'package:jappcare/features/emergency/navigation/private/emergency_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';
import 'package:geolocator/geolocator.dart';
class EmergencyDetailController extends GetxController {
  final AppNavigation _appNavigation;
  final EmergencyUseCase _emergencyUseCase = Get.find();
  EmergencyDetailController(this._appNavigation);
  var savePhoneNumberPaymentMethod = false.obs ;
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final loading = false.obs;
  var selectedVehiculeId = "".obs ;
  var selectedVehicleName = "".obs;
 final emergencyId = "".obs;
   Rxn<String>selectedVehiculeUrl = Rxn<String>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var userLocation = Rx<Position?>(null) ;
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    getUserLocation();
  }

  void goBack(){
    _appNavigation.goBack();
  }
  void goToWaitResponse(String note, String issue , String name , String emergencyId){
    _appNavigation.toNamed(EmergencyPrivateRoutes.emergencyWaitResponse , arguments: {
      "note" : note,
      "issue" : issue,
      "name": name,
      "emergencyId":emergencyId

    });
  }
  Future<void> emergencyAssistance(String issue , Location location , String vehicleId , String title, String note , String status,
      String id ,String userId
      ) async {
    loading.value = true;
    final result = await _emergencyUseCase.call(
        EmergencyCommand(
            serviceCenterId: "0c97d1dc-8f1f-4b63-8d18-8dbcf9a934f2",
            vehicleId: vehicleId,
            title: title,
            note: note,
            status: status,
            location: location

        )
    );
    result.fold(
          (e) {
        loading.value = false;
        print(e);
        if(Get.context !=null) {
          Get.showCustomSnackBar(e.message);
        }
      },
          (response) {
        goToWaitResponse(noteController.text ,issue , selectedVehicleName.value , emergencyId.value);
        emergencyId.value = response.id ;
        loading.value = false;
        print(response);
      },
    );
  }
  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifie si le service de localisation est activé
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Le service de localisation est désactivé");
      return;
    }

    // Vérifie les autorisations
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Les autorisations sont refusées");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Les autorisations sont définitivement refusées");
      return;
    }

    // Récupère la position actuelle
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      userLocation.value = position; // Met à jour la localisation
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      print("Erreur lors de la récupération de la position : $e");
    }
  }
}
