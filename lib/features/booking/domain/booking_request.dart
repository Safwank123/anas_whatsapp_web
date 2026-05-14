class BookingRequest {
  const BookingRequest({
    required this.name,
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    required this.children,
    required this.belowFive,
  });

  final String name;
  final DateTime checkIn;
  final DateTime checkOut;
  final int adults;
  final int children;
  final int belowFive;

  Map<String, Object?> toFirestore() {
    return {
      'name': name,
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'adults': adults,
      'children': children,
      'belowFive': belowFive,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'source': 'flutter_web',
    };
  }

  String toWhatsAppMessage() {
    final nights = checkOut.difference(checkIn).inDays;

    return '''
Hello Aurelia Resort,

I would like to make a booking enquiry.

Name: $name
Check-in: ${_formatDate(checkIn)}
Check-out: ${_formatDate(checkOut)}
Nights: $nights
Adults (12 yr above): $adults
Children (6-12 yr): $children
Below 5 yr: $belowFive

Please share availability and tariff details.''';
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
