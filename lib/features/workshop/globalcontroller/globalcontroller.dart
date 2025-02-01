import 'package:get/get.dart';
import 'dart:io';

import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
class GlobalcontrollerWorkshop extends GetxController {
  var workshopData = {}.obs; // Stocke les données sous forme de Map
  var selectedImages = <File>[].obs;
  late Vehicle  selectVehicle  ;
  // Ajouter une seule donnée
  void addData(String key, dynamic value) {
    workshopData[key] = value;
  }
  void addVehicle(Vehicle vehicle){
    selectVehicle = vehicle ;
  }
  // Ajouter plusieurs données à la fois
  void addMultipleData(Map<String, dynamic> newData) {
    workshopData.addAll(newData);
  }
  // Ajouter une image
  void addImage(File image) {
    selectedImages.add(image);
  }

  // Ajouter plusieurs images
  void addMultipleImages(List<File> images) {
    selectedImages.addAll(images);
  }

  // Supprimer une image spécifique
  void removeImage(File image) {
    selectedImages.remove(image);
  }

  // Réinitialiser toutes les données
  void resetData() {
    workshopData.clear();
  }
}