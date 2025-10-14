import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/utils/enums.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/authentification/application/usecases/phone_command.dart';
import 'package:jappcare/features/profile/application/command/add_payment_method_command.dart';
import 'package:jappcare/features/profile/application/usecases/add_payment_method_usecase.dart';
import 'package:jappcare/features/profile/domain/core/exceptions/profile_exception.dart';

class AddPaymentMethodController extends GetxController {
  // Add payment method
  late FormHelper formHelper;


  // Use cases
  final AddPaymentMethodUseCase _addPaymentMethodUseCase = Get.find();

  final RxString phoneCode = ''.obs;

  final AppNavigation _appNavigation;
  AddPaymentMethodController(this._appNavigation);

  @override
  onInit() {
    // Generate by Menosi_cli
    super.onInit();
    formHelper = FormHelper<ProfileException, String>(
      fields: {
        "phoneNumber": null,
        "cardNumber": null,
      },
      validators: {
        "phoneNumber": Validators.requiredField,
        "cardNumber": Validators.requiredField,
      },
      onSubmit: (data) {
        return _addPaymentMethodUseCase.call(AddPaymentMethodCommand(
          type: PaymentMethod.mtn,
          phone: data['phoneNumber'] != null ? PhoneCommand(
            number: data['phoneNumber']!,
            code: phoneCode.value.replaceAll("+", ""),
          ) : null));
      },
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        // _appNavigation.goBack();
        Get.showCustomSnackBar("Profile updated successfully. But phone number update is not yet supported",
            title: "Profile updated", type: CustomSnackbarType.success);
        // update();
        // } else {
        //   Get.showCustomSnackBar(response.message ?? "An error occurred");
        // }
      },
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }

  // void goToAddPaymentMethodForm(String? methode) {
  //   // Get.back();
  //   if (methode == PaymentMethod.card.value) {
  //     _appNavigation.toNamed(ProfilePrivateRoutes.addCardPaymentMethod);
  //   }
  //   if (methode == PaymentMethod.mtn.value ||
  //       methode == PaymentMethod.orange.value) {
  //     _appNavigation.toNamed(ProfilePrivateRoutes.addMomoPaymentMethod);
  //   }
  // }
}
