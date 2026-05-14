import 'package:url_launcher/url_launcher.dart';

import '../domain/booking_request.dart';

class WhatsAppLauncher {
  const WhatsAppLauncher({
    this.phoneNumber = '917034471603',
  });

  final String phoneNumber;

  Future<void> openBookingChat(BookingRequest request) async {
    final uri = Uri.https('wa.me', '/$phoneNumber', {
      'text': request.toWhatsAppMessage(),
    });

    if (!await launchUrl(uri, webOnlyWindowName: '_blank')) {
      throw Exception('Could not open WhatsApp');
    }
  }
}
