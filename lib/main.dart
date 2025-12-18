import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_flutter/features/auth/view/mobile_input_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kept',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      // theme: ThemeData(fontFamily: 'Inter'),
      home: MobileInputScreen(),
      // home: HomeScreen(),
    );
  }
}
