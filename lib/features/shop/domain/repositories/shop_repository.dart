import 'package:dartz/dartz.dart';

import '../core/exceptions/shop_exception.dart';
import '../entities/get_products.dart';


abstract class
 ShopRepository {
  //Add methods here
  Future<Either<ShopException, GetProducts>> getProducts();

}


