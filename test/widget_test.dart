import 'package:flutter_test/flutter_test.dart';

import 'package:catatanku/main.dart';

void main() {
  testWidgets('alur splash menuju login dan beranda', (tester) async {
    await tester.pumpWidget(const CatatanKuApp());

    expect(find.text('CatatanKu'), findsOneWidget);
    expect(find.text('Masuk untuk melanjutkan'), findsNothing);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Masuk untuk melanjutkan'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);

    await tester.tap(find.text('Masuk').first);
    await tester.pumpAndSettle();

    expect(find.text('Halo,'), findsOneWidget);
    expect(find.text('Ahmadi 👋'), findsOneWidget);
    expect(find.text('Ide Aplikasi'), findsOneWidget);
  });
}
