import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestTimonialWidget extends StatelessWidget{
  final String text ;
  final int rate;
  final String name ;
  final DateTime date;
  TestTimonialWidget({
    Key?key,
    required this.name,
    required this.date,
    required this.rate,
    required this.text
 }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width*.95,
      decoration: BoxDecoration(
        border: Border.all(width: 1 , color: Color(0xFFF6EFF3)),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 14),
          ),
          SizedBox(height: 10,),
         Row(
           children:
             List.generate(5, (index) {
               return Icon(
                   index < rate
                       ? FluentIcons.star_16_filled
                       : Icons.star_border, // Étoile pleine ou vide
                   color: Colors.black,
                   size: 16,
                 );

             }),

         ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(name),
              Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
              Text( DateFormat('EEE, MMM dd, yyyy').format(date))

            ],
          ),

        ],
      ),
    );
  }
}