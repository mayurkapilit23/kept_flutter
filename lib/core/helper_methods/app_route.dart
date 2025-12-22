import 'package:flutter/material.dart';

// class AppRoute {
//   static Route smooth(Widget screen) {
//     return PageRouteBuilder(
//       transitionDuration: const Duration(milliseconds: 150),
//       pageBuilder: (_, __, ___) => screen,
//       transitionsBuilder: (_, animation, __, child) {
//         return FadeTransition(opacity: animation, child: child);
//       },
//     );
//   }
// }

Future<void> navigateTo(context, Widget widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
