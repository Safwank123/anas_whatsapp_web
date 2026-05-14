import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/app_theme.dart';
import 'features/booking/presentation/resort_booking_page.dart';

class ResortBookingApp extends StatelessWidget {
  const ResortBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stay here',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(GoogleFonts.playfairDisplayTextTheme()),
      home: const ResortBookingPage(),
    );
  }
}
