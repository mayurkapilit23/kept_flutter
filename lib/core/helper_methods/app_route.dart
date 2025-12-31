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

class AppRoutes {
  AppRoutes._(); // private constructor

  static const String promiseInputScreen = '/promiseInputScreen';
  static const String selectPersonScreen = '/selectPersonScreen';
  static const String promiseListScreen = '/promiseListScreen';
  static const String promisePreviewScreen = '/promisePreviewScreen';
  static const String homeScreen = '/homeScreen';
  static const String mobileInputScreen = '/mobileInputScreen';
  static const String otpScreen = '/otpScreen';

}

Future<void> navigateTo(context, Widget widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
