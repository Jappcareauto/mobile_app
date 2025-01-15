import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
class ResumeAppointmentWidget extends StatelessWidget {
  final String services ;

  final DateTime date ;
  final String note ;
  final String fee ;
  final String time ;
  final String caseId;
    ResumeAppointmentWidget({
      Key? key,
      required this.services,

      required this.date,
      required this.note,
      required this.fee,
      required this.time,
      required this.caseId
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
              Text('Service Offered by',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal)),
              Text(services,
                  style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.bold )),
              SizedBox(height: 20,),
              Text('From',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal , color:  Colors.grey)),
              SizedBox(height: 10,),

              Row(
                children: [
                  if (Get.isRegistered<FeatureWidgetInterface>(
                      tag: 'AvatarWidget'))
                    Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
                        .buildView({
                      "haveName":true
                    }),
                  SizedBox(width: 10,),

                  Text( Get.find<ProfileController>().userInfos?.name?? "Unknow",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(height: 20,),
              Text('Estimated inspection Fee',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal , color:  Colors.grey)),
              Text(fee,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold )),
              SizedBox(height: 20,),
              Text('Case ID',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal)),
              Text(caseId,
                  style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.bold )),
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