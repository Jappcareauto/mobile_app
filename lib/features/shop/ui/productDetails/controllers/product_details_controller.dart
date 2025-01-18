import 'package:get/get.dart';
import 'package:jappcare/core/services/networkServices/dio_network_service.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/shop/application/usecases/get_product_detail_command.dart';
import 'package:jappcare/features/shop/application/usecases/get_product_detail_usecase.dart';
import 'package:jappcare/features/shop/domain/entities/get_product_detail.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class ProductDetailsController extends GetxController {
  final AppNavigation _appNavigation;
  // GetProductDetailUseCase getProductDetailUseCase = Get.find() ;
  Rxn<GetProductDetail> product = Rxn<GetProductDetail>() ;
  ProductDetailsController(this._appNavigation);
  var quantity = 0.obs ;
  var totalPrice = 0.obs;
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    // getProductDetail(Get.arguments['productId']);
  }

  void goBack(){
    _appNavigation.goBack();
  }
  void addQuantity(double price){
    quantity.value++;
    totalPrice.value = quantity.value*price.toInt() ;
  }
  void removeQuantity(double price){
    quantity.value--;
    totalPrice.value = quantity.value*price.toInt() ;
  }
  void goToBag () {
    _appNavigation.toNamed(ShopPrivateRoutes.bag);
  }
  // Future<void> getProductDetail(String productId) async  {
  //   final result = await getProductDetailUseCase(GetProductDetailCommand(productId: productId));
  //   result.fold(
  //           (error){
  //             print(error.message);
  //             Get.showCustomSnackBar(error.message);
  //           },
  //           (response){
  //             product.value = response ;
  //           });
  // }
}
