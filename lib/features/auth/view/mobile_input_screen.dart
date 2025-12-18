import 'package:flutter/material.dart';
import 'package:kept_flutter/features/auth/view/otp_verification_screen.dart';

import '../../../core/colors/app_colors.dart';

class MobileInputScreen extends StatefulWidget {
  const MobileInputScreen({super.key});

  @override
  State<MobileInputScreen> createState() => _MobileInputScreenState();
}

class _MobileInputScreenState extends State<MobileInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            onChanged: () {
              setState(() {
                isValid = _formKey.currentState!.validate();
              });
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Mobile Number",
                    style: TextStyle(
                      // color: isDark
                      //     ? AppColors.whiteColor
                      //     : AppColors.darkPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We will send an OTP to verify your number.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 25),

                  // PHONE FIELD
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    autofocus: true,

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDark
                              ? Colors.white
                              : Colors.black, // 👈 focus border color
                          width: 1.2,
                        ),
                      ),
                      counterText: "",
                      labelText: "Mobile Number",
                      labelStyle: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      prefixText: "+91 ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mobile number is required";
                      }
                      if (value.length != 10) {
                        return "Enter a valid 10-digit number";
                      }
                      if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                        return "Enter a valid Indian mobile number";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  // SUBMIT BUTTON
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpVerificationSheet(
                                    phoneNumber: _phoneController.text,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // if (state is AuthLoading)
                  //   Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
