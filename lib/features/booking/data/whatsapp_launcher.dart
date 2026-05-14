import 'package:url_launcher/url_launcher.dart';

import '../domain/booking_request.dart';

class WhatsAppLauncher {
  const WhatsAppLauncher({
    this.phoneNumber = '917034471603',
  });

  final String phoneNumber;

  Future<void> openBookingChat(BookingRequest request) async {
    final uri = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(request.toWhatsAppMessage())}',
    );

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    )) {
      throw Exception('Could not open WhatsApp');
    }
  }
}
