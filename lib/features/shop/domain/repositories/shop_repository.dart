import 'package:dartz/dartz.dart';

import '../core/exceptions/shop_exception.dart';
import '../entities/get_products.dart';



import '../entities/get_product_detail.dart';


abstract class

 ShopRepository {
  //Add methods here
  Future<Either<ShopException, List<Data>>> getProducts();

  Future<Either<ShopException, GetProductDetail>> getProductDetail(String productId);

}



