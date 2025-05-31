// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/routes/transitions_type.dart';

// class BounceTransition extends Transition {
//   @override
//   Widget buildTransition(
//     BuildContext context,
//     CurveTween opacity,
//     CurveTween transform,
//     Widget child,
//   ) {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: Offset(0, 1),
//         end: Offset(0, 0),
//       ).animate(transform),
//       child: Opacity(
//         opacity: opacity.animate(Animatable(
//           curve: Curves.bounceOut,
//         )),
//         child: child,
//       ),
//     );
//   }
// }
