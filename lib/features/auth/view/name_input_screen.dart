import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/features/promise/widgets/custom_button.dart';

import '../../../core/colors/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _nameController = TextEditingController();

  bool get _isValid => _nameController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    context.read<AuthBloc>().add(SubmitName(name));
    debugPrint('User name: $name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kept',
                style: TextStyle(fontSize: 35, letterSpacing: 0.0),
              ),
              const SizedBox(height: 40),

              const Text(
                'What should we call you?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              const Text(
                'Enter your full name to continue',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 32),

              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: AppColors.darkPrimary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.darkPrimary,
                      width: 1.2,
                    ),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),

              const Spacer(),

              CustomButton(
                width: ButtonWidth.full,
                height: ButtonHeight.medium,
                title: 'Continue',
                onPressed: _isValid ? _onContinue : null,
              ),

              // SizedBox(
              //   width: double.infinity,
              //   height: 48,
              //   child: ElevatedButton(
              //     onPressed: _isValid ? _onContinue : null,
              //     child: const Text('Continue'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
