import 'package:flutter/material.dart';
import 'controllers/product_details_controller.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('ProductDetails Screen'),
      ),
      body:  Center(
        child: Text('Welcome to ProductDetails Screen'),
      ),
    );
  }
}
