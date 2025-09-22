import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {required this.bodyText,
      super.key,
      required this.coloriage,
      this.textSize,
      this.haveTitle,
      this.circleIcon,
      required this.icon,
      required this.backgroundColor,
      required this.title,
      this.onTap});
  final IconData icon;
  final Color coloriage;
  final Color? backgroundColor;
  final String bodyText;
  final double? textSize;
  final bool? haveTitle;
  final bool? circleIcon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              title: haveTitle == true
                  ? Row(
                      spacing: 10,
                      children: [
                        circleIcon == true
                            ? Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: coloriage, shape: BoxShape.circle),
                                child:
                                    Icon(icon, size: 16, color: Colors.white),
                              )
                            : Icon(icon, size: 20, color: coloriage),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: coloriage),
                        ),
                      ],
                    )
                  : const SizedBox(),
              subtitle: Row(
                spacing: 16,
                children: [
                  Flexible(
                    child: Text(
                      bodyText,
                      style: TextStyle(fontSize: textSize ?? 16),
                    ),
                  ),
                  CircleAvatar(
                      backgroundColor: coloriage.withValues(alpha: .1),
                      radius: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundColor: coloriage,
                          radius: 20,
                          child: Icon(
                            icon,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),

      // Column(
      //   children: [
      //     InkWell(
      //       onTap: onTap,
      //       child: ListTile(
      //         contentPadding: const EdgeInsets.only(left: 16, right: 16),
      //         title: haveTitle == true
      //             ? Row(
      //               spacing: 10,
      //                 children: [
      //                   circleIcon == true
      //                       ? Container(
      //                           padding: const EdgeInsets.all(3),
      //                           decoration: BoxDecoration(
      //                               color: coloriage, shape: BoxShape.circle),
      //                           child:
      //                               Icon(icon, size: 16, color: Colors.white),
      //                         )
      //                       : Icon(icon, size: 20, color: coloriage),
      //                   Text(
      //                     title,
      //                     style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.bold,
      //                         color: coloriage),
      //                   ),
      //                 ],
      //               )
      //             : const SizedBox(),
      //         subtitle: Text(
      //           bodyText,
      //           style: TextStyle(fontSize: textSize ?? 16),
      //         ),
      //         trailing: CircleAvatar(
      //             backgroundColor: coloriage.withValues(alpha: .1),
      //             radius: 35,
      //             child: Padding(
      //               padding: const EdgeInsets.all(10.0),
      //               child: CircleAvatar(
      //                 backgroundColor: coloriage,
      //                 radius: 20,
      //                 child: Icon(
      //                   icon,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             )),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

/* 'Your repair from the Japcare Autotech shop is ready, and available for pickup'*/ 