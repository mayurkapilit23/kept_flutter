import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/colors/app_colors.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/view/home_screen.dart';
import 'package:pinput/pinput.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class OtpVerificationScreen extends StatefulWidget {
  String phoneNumber;

  OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool isValid = false;
  String _otpValue = "";

  @override
  Widget build(BuildContext context) {
    log('OtpVerificationScreen => ${widget.phoneNumber}');
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (req, res) {
        context.read<AuthBloc>().add(GoBackFromOtp());
      },
      child: Scaffold(
        backgroundColor: context.isDark
            ? AppColors.darkSecondary
            : AppColors.lightPrimary,

        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verify OTP",
                    style: TextStyle(
                      fontSize: 22,
                      color: context.isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Enter the 6-digit code sent to +91 ${widget.phoneNumber}",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      // OTP input fields
                      Pinput(
                        length: 6,
                        defaultPinTheme: PinTheme(
                          width: 48,
                          height: 58,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 48,
                          height: 58,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                        onChanged: (value) {
                          // _otpValue = value;
                          // setState(() {
                          //   isValid = value.length == 6;
                          // });
                        },
                        onCompleted: (value) {
                          _otpValue = value;
                          setState(() {
                            isValid = value.length == 6;
                          });
                        },
                      ),

                      SizedBox(height: 40),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isValid
                                ? Colors.black
                                : Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: isValid
                              ? () {
                                  // Verify OTP API here
                                  context.read<AuthBloc>().add(
                                    SubmitOtp(otp: _otpValue),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                }
                              : null,
                          child: Text(
                            "Verify",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
