import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:techtrack/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Bangun widget utama
    await tester.pumpWidget(MyApp());

    // Temukan teks awal '0' dan periksa keberadaannya
    expect(find.text('0'), findsOneWidget);

    // Tekan tombol untuk meningkatkan hitungan
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Periksa apakah teks '1' muncul setelah peningkatan
    expect(find.text('1'), findsOneWidget);
  });
}
