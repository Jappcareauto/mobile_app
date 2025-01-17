import 'package:get/get.dart';
import 'package:jappcare/features/shop/domain/entities/cardItams.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class BagController extends GetxController {
  final AppNavigation _appNavigation;
  var quantity = 1.obs;
  var totalPrices = 0.0.obs;
  var cartItems = <CartItem>[].obs;

  BagController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    ever(cartItems, (_) => updateTotalPrices());
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void incrementQuantity() {
    quantity.value++;
    updateTotalPrice();
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      updateTotalPrice();
    }
  }

  void goToCheckout() {
    _appNavigation.toNamed(ShopPrivateRoutes.checkout);
  }

  void addToCart(CartItem item) {
    // Vérifier si l'article est déjà dans le panier
    int index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      // Si le produit existe, augmenter la quantité
      cartItems[index].quantity++;
      cartItems.refresh(); // Rafraîchir pour mettre à jour l'interface
    } else {
      // Sinon, ajouter un nouvel article
      cartItems.add(item);
    }
  }

  // Supprimer un produit
  void removeFromCart(int id) {
    cartItems.removeWhere((item) => item.id == id);
  }

  // Mettre à jour la quantité
  void updateQuantity(String id, int quantity) {
    print('object');

    if (quantity <= 0) {
      // Si la quantité est inférieure ou égale à 0, supprimer l'article
      cartItems.removeWhere((item) => item.id == id);
    } else {
      // Trouver l'index de l'article avec l'ID correspondant
      int index = cartItems.indexWhere((item) => item.id.trim() == id.trim());
      if (index != -1) {
        cartItems[index].quantity = quantity;
        print('object');
        print(cartItems[index].quantity);
        updateTotalPrices();
        cartItems.refresh(); // Rafraîchir pour mettre à jour l'UI
      }
    }
  }

  void updateTotalPrice() {
    totalPrices.value = quantity.value * 125000; // Prix unitaire
  }

  void updateTotalPrices() {
    totalPrices.value =
        cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}