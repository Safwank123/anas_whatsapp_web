import 'package:url_launcher/url_launcher.dart';

import '../domain/booking_request.dart';

class WhatsAppLauncher {
  const WhatsAppLauncher({
    this.phoneNumber = '917034471603',
  });

  final String phoneNumber;

  Future<void> openBookingChat(BookingRequest request) async {
    final uri = Uri.parse(
      'https://api.whatsapp.com/send/?phone=$phoneNumber&text=${Uri.encodeComponent(request.toWhatsAppMessage())}',
    );

    if (!await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_self',
    )) {
      throw Exception('Could not open WhatsApp');
    }
  }
}
