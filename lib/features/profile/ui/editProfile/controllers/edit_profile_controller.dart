import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/authentification/application/usecases/phone_command.dart';
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
  EditProfileController(this._appNavigation);

  // Use cases
  final UpdateProfileUseCase _editProfileUseCase = Get.find();
  final GetPlaceDetailsUseCase _getPlaceDetailsUseCase = Get.find();
  final GetPlaceAutocompleteUsecase _getPlaceAutocompleteUseCase = Get.find();

  ProfileController currentUserController = Get.find<ProfileController>();

  // Update profile details form helper
  late FormHelper editProfileFormHelper;

  // Uuid for new location search session
  final Uuid _uuid = const Uuid();

  // A new session token should be generated for each autocomplete session.
  Rx<String?> sessionToken = Rx<String?>(null);

  RxString placeInput =
      "".obs; // Text input observable for location debounce search
  final locationLoading = true.obs; // Loading observable
  RxList<PlacePrediction> placePredictions = <PlacePrediction>[].obs;
  Rx<PlaceDetails?> placeDetails = Rx<PlaceDetails?>(null); // placeDetails;
  final Rx<DateTime?> _selectedDate = Rx<DateTime?>(null);
  final RxString phoneCode = ''.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    if(currentUserController.userInfos?.location != null){
      placeDetails.value = PlaceDetails.create(
        name: currentUserController.userInfos!.location!.name!,
        lat: currentUserController.userInfos!.location!.latitude!,
        lng: currentUserController.userInfos!.location!.longitude!,
      );
    }
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
        "phoneNumber": Validators.requiredField,
        "dateOfBirth": Validators.validateDateOfBirth,
      },
      onSubmit: (data) {
        return _editProfileUseCase.call(UpdateProfileCommand(
          name: data['name']!,
          email: data['email']!,
          dateOfBirth: data['dateOfBirth']!,
          phone: data['phoneNumber'] != null ? PhoneCommand(
            number: data['phoneNumber']!,
            code: phoneCode.value.replaceAll("+", ""),
          ) : null,
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
        // _appNavigation.goBack();
        Get.showCustomSnackBar("Profile updated successfully. But phone number update is not yet supported",
            title: "Profile updated", type: CustomSnackbarType.success);
        currentUserController.getUserInfos(refreshAll: false);
        // update();
        // } else {
        //   Get.showCustomSnackBar(response.message ?? "An error occurred");
        // }
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

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: _selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
      editProfileFormHelper.controllers['dateOfBirth']?.text =
          "${picked.year}-${picked.month < 10 ? "0${picked.month}" : picked.month}-${picked.day < 10 ? "0${picked.day}" : picked.day}";
      update();
    }
  }
}
