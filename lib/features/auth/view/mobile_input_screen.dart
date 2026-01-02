import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/auth/bloc/auth_bloc.dart';
import 'package:kept_flutter/features/auth/bloc/auth_event.dart';
import 'package:kept_flutter/features/auth/bloc/auth_state.dart';
import 'package:kept_flutter/features/promise/widgets/custom_button.dart';

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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (result, jghj) {
        context.read<AuthBloc>().add(GoBackFromMobile());
      },
      child: Scaffold(
        backgroundColor: context.isDark
            ? AppColors.darkSecondary
            : AppColors.lightPrimary,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return SafeArea(
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
                            color: context.isDark ? Colors.white : Colors.black,
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
                                color: context.isDark
                                    ? Colors.white
                                    : Colors.black, //focus border color
                                width: 1.2,
                              ),
                            ),
                            counterText: "",
                            labelText: "Mobile Number",
                            labelStyle: TextStyle(
                              color: context.isDark
                                  ? Colors.white
                                  : Colors.black,
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
                        CustomButton(
                          title: 'Continue',
                          onPressed: isValid
                              ? () {
                                  context.read<AuthBloc>().add(
                                    SubmitMobile(
                                      _phoneController.text.toString().trim(),
                                    ),
                                  );
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
