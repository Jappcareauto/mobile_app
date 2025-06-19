import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/shop/domain/entities/cardItams.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import 'package:jappcare/features/shop/ui/bag/widgets/delete_model.dart';
import '../../../../../core/navigation/app_navigation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BagController extends GetxController {
  final AppNavigation _appNavigation;
  var quantity = 1.obs;
  var totalPrices = 0.0.obs;
  var cartItems = <CartItem>[].obs;

  BagController(this._appNavigation);

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  Future<void> saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final items = cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cartItems', items);
    print('object');
    print(items);
  }

  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList('cartItems') ?? [];
    cartItems.value =
        items.map((item) => CartItem.fromJson(jsonDecode(item))).toList();
  }

  void addToCart(CartItem item) {
    int index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(item);
    }
    cartItems.refresh();
    saveCartItems();
    updateTotalPrices();
  }

  void removeFromCart(String id) {
    cartItems.removeWhere((item) => item.id == id);
    saveCartItems();
    updateTotalPrices();
    cartItems.refresh();
    _appNavigation.goBack();

    if (cartItems.isEmpty) {
      _appNavigation.goBack();
      _appNavigation.goBack();
    }
  }

  void updateQuantity(String id, int quantity) {
    if (quantity <= 0) {
      showDeleteModal(id);
    } else {
      int index = cartItems.indexWhere((item) => item.id.trim() == id.trim());
      if (index != -1) {
        cartItems[index].quantity = quantity;
        cartItems.refresh();
        saveCartItems();
        updateTotalPrices();
      }
    }
  }

  void updateTotalPrices() {
    totalPrices.value =
        cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    totalPrices.refresh();
  }

  void goToCheckout() {
    if (cartItems.isNotEmpty) {
      _appNavigation.toNamed(ShopPrivateRoutes.checkout);
    } else {
      Get.snackbar("Panier vide", "Ajoutez des articles avant de continuer !");
    }
  }

  void showDeleteModal(String id) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => DeleteModel(id: id),
    );
  }
}
