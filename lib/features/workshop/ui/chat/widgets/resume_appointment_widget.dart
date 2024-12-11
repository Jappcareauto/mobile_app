import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
class ResumeAppointmentWidget extends StatelessWidget {
  final String services ;
  final String vehicule ;
  final DateTime date ;
  final String note ;
  final String fee ;
  final String time ;
    ResumeAppointmentWidget({
      Key? key,
      required this.services,
      required this.vehicule,
      required this.date,
      required this.note,
      required this.fee,
      required this.time

    }):super( key:key );
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(20),

        ),
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Services',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal)),
              Text(services,
                  style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.bold )),
              SizedBox(height: 20,),
              Text('Vehicule',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal , color:  Colors.grey)),
              Text(vehicule,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold )),
              SizedBox(height: 20,),
              Text('Date',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal , color:  Colors.grey)),
              Row(
                  children: [
                    Icon(
                      FluentIcons.calendar_3_day_20_regular,

                    ),

                        Container(
                          child: Text(
                            DateFormat('EEE, MMM dd, yyyy').format(
                               date),
                            // Format personnalisé
                            style: TextStyle(
                              fontSize: 14,

                            ),
                          ),
                        ),


                    SizedBox(width: 20),
                    Icon(
                      FluentIcons.clock_12_regular,

                    ),

                        Text(
                           time, style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.w300 ))

                  ]
              ),
              SizedBox(height: 20,),
              Text('Note',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal, color:  Colors.grey)),
              Text(note,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold )),
              SizedBox(height: 20,),
              Text('Estimated inspection Fee',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal , color:  Colors.grey)),
              Text(fee,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold )),
              SizedBox(height: 20,),

             Align(
               alignment: Alignment.bottomRight,
            child:
                 CustomButton(
                     text: 'See Details',
                     strech: false,
                     width: 170,
                     borderRadius: BorderRadius.circular(30),
                     haveBorder: true,
                     onPressed: (){
                   print('view detail');
                 }
                 )

             )
            ]
        )
    );
  }


}