import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/shop/ui/productDetails/widgets/product_detail_widget.dart';
class ItemContainer extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final RxInt quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool modifyQuantity ;
  final String assetPath ;
  const ItemContainer({
    Key? key,
    required this.assetPath,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.modifyQuantity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: assetPath != null ?
                    ImageComponent(
                      assetPath: assetPath,
                      width: 96,
                      height: 96,
                    ) :
                    ImageComponent(
                      imageUrl: imageUrl,
                      width: 96,
                      height: 96,
                    )
              ),
              const SizedBox(width: 16),
              Expanded(child:
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              )
            ],
          ),
          Row(
            children: [
            modifyQuantity ?Column (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price' ,  style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 , color: Color(0xFF797676) , fontFamily:'PlusJakartaSans' ),),
                  Text(
                    "${NumberFormat('#,###').format(price)} Frs",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ) :
            Row (
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price :  ' ,  style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 , color: Color(0xFF797676) , fontFamily:'PlusJakartaSans' ),),
                Text(
                  "${NumberFormat('#,###').format(price)} Frs",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            )
              ,
              SizedBox(width: modifyQuantity ? MediaQuery.of(context).size.width*.30 :MediaQuery.of(context).size.width*.30 ,),

              Row(
                children: [
                  Text('Qty:'),
                  SizedBox(width: 5,),
                  modifyQuantity
                      ?  QuantityButton(
                    icon: Icons.remove,
                    onPressed: () {
                      },
                  ):
                  SizedBox() ,



                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '2',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  modifyQuantity
                      ?
                    QuantityButton(
                      icon: Icons.add,
                      onPressed: () {

                      },
                    )
                      : SizedBox() ,

                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text('Total' , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 , color: Color(0xFF797676) , fontFamily:'PlusJakartaSans'),),
              SizedBox(width: MediaQuery.of(context).size.width*.5,),

              Text("${NumberFormat('#,###').format(price)} Frs" , style: TextStyle(fontSize:16 , fontWeight: FontWeight.w600 , color: Get.theme.primaryColor ),)
            ],
          )
        ],
      ),
    );
  }
}