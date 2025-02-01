import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/workshop/domain/entities/get_allservices.dart';

class TabsListWidgets extends StatelessWidget{
  final List<String> tabs ;

  final RxInt selectedFilter ;
  late RxString selectedTabs ;
  final List<Data>? data ;
  final BorderRadius borderRadius ;
  final bool haveBorder ;
  final Function(Data selectCar)? onSelected;
  TabsListWidgets({
    Key?key,
    required this.tabs,
    this.data,
     this.onSelected,
    required this.selectedFilter,
    required this.selectedTabs,
    required this.borderRadius,
    required this.haveBorder
}):super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data!.isNotEmpty && onSelected != null) {
        onSelected!(data![0]);
      }
    });
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:  Row(
        children: List.generate(tabs.length, (index){
          return Obx((){
            final category = tabs[index];
            return GestureDetector(
              onTap: (){
                selectedFilter.value = index ;
                selectedTabs.value = category ;
                onSelected!(data![index]);
              },
              child: Container(

                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),


                decoration: BoxDecoration(
                  color:selectedFilter.value == index ?
                   haveBorder == true
                      ? AppColors.secondary
                      : AppColors.primary
                      : AppColors.secondary
                  ,
                  border: Border.all(
                      color:
                      selectedFilter.value == index

                      ? Color(0xFFFB7C37)
                      : Color(0xFFFFEDE6) , width: 1.5),
                  borderRadius:borderRadius,
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedFilter.value == index ?
                      haveBorder == true
                          ? AppColors.black
                          : AppColors.white
                          : AppColors.black
                      ,

                    ),
                  ),
                ),
              ),
            );
          });
        }),


      ),
    );
  }

}