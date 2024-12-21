import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DismissWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
  alignment: Alignment.centerRight,
     decoration: BoxDecoration(
       color: Color(0xFFFFDBCC),
       // Couleur de fond de la notification
       borderRadius: BorderRadius.circular(16), // Coins arrondis
     ),
     padding: EdgeInsets.symmetric(horizontal: 20),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Icon(
           FluentIcons.dismiss_24_regular, // Icône de Fluent Icons
           color: Colors.red,
           size: 28,
         ),
         SizedBox(height: 5), // Espacement entre l'icône et le texte
         Text(
           "Dismiss",
           style: TextStyle(
             color: Colors.red,
             fontSize: 12,
             fontWeight: FontWeight.w600,
           ),
         ),
       ],
     ),
   );
  }

}