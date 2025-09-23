import 'dart:async';

import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/profile/domain/core/exceptions/profile_exception.dart';
import 'package:jappcare/features/profile/domain/entities/update_user_details.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/application/usecases/get_place_autocomplete_usecase.dart';
import 'package:jappcare/features/workshop/application/usecases/get_place_details_usecase.dart';
import 'package:jappcare/features/workshop/domain/entities/place_details.dart';
import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../application/usecases/update_profile_usecase.dart';
import '../../../application/command/update_profile_command.dart';

class EditProfileController extends GetxController {
  final AppNavigation _appNavigation;
  final UpdateProfileUseCase _editProfileUseCase = Get.find();

  EditProfileController(this._appNavigation);

  ProfileController currentUserController = Get.find<ProfileController>();
  
  // Update profile details form helper
  late FormHelper editProfileFormHelper;

  // Uuid for new location search session
  final Uuid _uuid = const Uuid();

  // A new session token should be generated for each autocomplete session.
  Rx<String?> sessionToken = Rx<String?>(null);

  final GetPlaceDetailsUseCase _getPlaceDetailsUseCase = Get.find();
  final GetPlaceAutocompleteUsecase _getPlaceAutocompleteUseCase = Get.find();

  RxString placeInput = "".obs; // Text input observable for location debounce search
  final locationLoading = true.obs; // Loading observable

  RxList<PlacePrediction> placePredictions = <PlacePrediction>[].obs;
  Rx<PlaceDetails?> placeDetails = Rx<PlaceDetails?>(null); // placeDetails;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    editProfileFormHelper = FormHelper<ProfileException, UpdateUserDetails>(
      fields: {
        "name": currentUserController.userInfos?.name,
        "email": currentUserController.userInfos?.email,
        "address": currentUserController.userInfos?.location?.name,
        "phoneNumber": null,
        "dateOfBirth": currentUserController.userInfos?.dateOfBirth,
      },
      validators: {
        "name": Validators.requiredField,
        "email": Validators.email,
        // "address": Validators.requiredField,
        // "phoneNumber": Validators.requiredField,
        "dateOfBirth": Validators.requiredField,
      },
      onSubmit: (data) {
        print(placeDetails.value);
        return _editProfileUseCase.call(UpdateProfileCommand(
          name: data['name']!,
          email: data['email']!,
          dateOfBirth: data['dateOfBirth']!,
          phone: data['phoneNumber'],
          address: data['address'],
          location: placeDetails.value != null
              ? LocationEntity.create(
                  latitude: placeDetails.value!.lat,
                  longitude: placeDetails.value!.lng,
                  name: placeDetails.value!.name,
                )
              : null,
        ));
      },
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        print(response);
        if (response.state == true) {
          Get.showCustomSnackBar("Profile updated successfully",
              isError: false);
          currentUserController.getUserInfos();
          _appNavigation.goBack();
          update();
        } else {
          Get.showCustomSnackBar(response.message ?? "An error occurred");
        }
        // Get.find<GarageController>().getVehicleList(user.id);
      },
    );

    debounce(placeInput, (value) {
      if (value.isNotEmpty &&
          editProfileFormHelper.controllers['address'] != null &&
          value == editProfileFormHelper.controllers['address']!.text) {
        getPlaceAutocomplete(value);
      } else {
        placePredictions.value = [];
      }
    }, time: const Duration(milliseconds: 500));

    editProfileFormHelper.controllers['address']?.addListener(() {
      if (editProfileFormHelper.controllers['address'] != null) {
        placeInput.value = editProfileFormHelper.controllers['address']!.text;

        // Generate a new session token when the user starts typing.
        if (sessionToken.value == null &&
            editProfileFormHelper.controllers['address']!.text.isNotEmpty) {
          sessionToken.value = _uuid.v4();
          update();
        }
      }
    });
  }

  void goBack() {
    _appNavigation.goBack();
  }

  Future<PlaceDetails?> getPlaceDetails(String placeId) async {
    if (sessionToken.value == null) return null;
    locationLoading.value = true;
    PlaceDetails? location;
    final result =
        await _getPlaceDetailsUseCase.call(placeId, sessionToken.value!);
    result.fold(
      (e) {
        locationLoading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (success) {
        locationLoading.value = false;
        location = success;
        update();

        return success;
      },
    );
    return location;
  }

  Future<List<PlacePrediction>?> getPlaceAutocomplete(String input) async {
    if (sessionToken.value == null) return null;
    locationLoading.value = true;
    List<PlacePrediction>? places;
    final result =
        await _getPlaceAutocompleteUseCase.call(input, sessionToken.value!);
    result.fold(
      (e) {
        locationLoading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (success) {
        placePredictions.value = success;
        places = success;
        locationLoading.value = false;
        print('placePredictions.value success: $success');
        return success;
      },
    );
    return places;
  }
}
