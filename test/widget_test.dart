import 'package:flutter_test/flutter_test.dart';

import 'package:catatanku/main.dart';

void main() {
  testWidgets('alur splash menuju login dan papan catatan', (tester) async {
    await tester.pumpWidget(const CatatanKuApp());

    expect(find.text('CatatanKu'), findsOneWidget);
    expect(find.text('Masuk untuk membuka papan catatanmu'), findsNothing);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Masuk untuk membuka papan catatanmu'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);

    await tester.tap(find.text('Masuk').first);
    await tester.pumpAndSettle();

    expect(find.text('Halo, Arif 👋'), findsOneWidget);
    expect(find.text('Papan Catatanku'), findsOneWidget);
    expect(find.text('Ide Aplikasi'), findsOneWidget);
  });
}
