import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp_web/app.dart';

void main() {
  testWidgets('shows resort booking form', (tester) async {
    await tester.pumpWidget(const ResortBookingApp());

    expect(find.text('Aurelia Resort'), findsWidgets);
    expect(find.text('Reserve your stay'), findsOneWidget);
    expect(find.text('Submit booking enquiry'), findsOneWidget);
  });
}
