import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:open_weather_test/main.dart';
import 'package:open_weather_test/screens/ui/weather.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    //unit test
    final counter = Weather();
    counter.createElement();
    expect(counter.createElement(), 1);

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
