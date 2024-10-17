import 'package:get/get.dart';

class Validators {
  static String? requiredField(String? value, {String fieldName = 'Ce champ'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName est requis';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Entrez un email valide';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? originalPassword) {
    if (value != originalPassword) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre numéro de téléphone';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Entrez un numéro de téléphone valide';
    }
    return null;
  }

  static String? number(String? value, {String fieldName = 'Ce champ'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName est requis';
    }
    if (!GetUtils.isNumericOnly(value)) {
      return '$fieldName doit être un nombre';
    }
    return null;
  }

  // Ajoutez d'autres validateurs si nécessaire
}

