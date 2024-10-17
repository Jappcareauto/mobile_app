import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

class FormHelper<L, R> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autovalidateMode = AutovalidateMode.disabled.obs;
  final Map<String, TextEditingController> controllers = {};
  final Map<String, String? Function(String?)?> validators = {};
  final RxBool isLoading = false.obs;

  final Future<Either<L, R>> Function(Map<String, String>)? onSubmit;
  final void Function(R)? onSuccess;
  final void Function(L)? onError;

  FormHelper({
    required Map<String, String?> fields,
     this.onSubmit,
    this.onSuccess,
    this.onError,
    Map<String, String? Function(String?)?>? validators,
  }) {
    final keys = fields.keys;
    for (var k in keys) {
      controllers[k] = TextEditingController(text:fields[k]??'');
      this.validators[k] = validators?[k];
    }
  }

  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());
  }

  void submit() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      if(onSubmit == null) return;
      try {
        final data = controllers.map((key, controller) => MapEntry(key, controller.text));
        final result = await onSubmit!(data);
        result.fold(
          (error) {
            if (onError != null) {
              onError!(error);
            } else {
              Get.snackbar('Erreur', error.toString(), snackPosition: SnackPosition.BOTTOM);
            }
          },
          (success) {
            if (onSuccess != null) {
              onSuccess!(success);
            } else {
              Get.snackbar('Succès', 'Opération réussie', snackPosition: SnackPosition.BOTTOM);
            }
          },
        );
      } catch (e) {
        Get.snackbar('Erreur', e.toString(), snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;
      }
    } else {
      autovalidateMode.value = AutovalidateMode.always;
    }
  }
}

