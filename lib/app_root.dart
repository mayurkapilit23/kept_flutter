import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/colors/app_colors.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/auth/bloc/auth_bloc.dart';
import 'package:kept_flutter/features/auth/view/mobile_input_screen.dart';
import 'package:kept_flutter/features/auth/view/otp_verification_screen.dart';
import 'package:kept_flutter/features/promise/view/home_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'features/auth/bloc/auth_state.dart';
import 'features/auth/view/name_input_screen.dart';

// class AppRoot extends StatelessWidget {
//   const AppRoot({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         log("AppRoot =>  $state");
//         if (state is AuthInitial) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => MobileInputScreen()),
//           );
//         }
//
//         if (state is OtpSent) {
//           log('AppRoot => PhoneNumber ${state.phone}');
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (c) => OtpVerificationScreen(phoneNumber: state.phone),
//             ),
//           );
//         }
//
//         if (state is Authenticated) {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//             (df) => false,
//           );
//         } else {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//             (df) => false,
//           );
//         }
//       },
//       child: SizedBox(),
//     );
//   }
// }

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        log("AppRoot => $state");

        if (state is NameInputRequired) {
          return const NameInputScreen();
        }

        if (state is AuthInitial) {
          return const MobileInputScreen();
        }

        if (state is OtpSent) {
          return OtpVerificationScreen(phoneNumber: state.phone);
        }

        if (state is Authenticated) {
          return const HomeScreen();
        }

        if (state is AuthLoading) {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: context.isDark
                    ? AppColors.lightSecondary
                    : AppColors.darkPrimary,
                size: 25,
              ),
            ),
          );
        }

        if (state is AuthError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        return const SizedBox(child: Text('hello'));
      },
    );
  }
}
