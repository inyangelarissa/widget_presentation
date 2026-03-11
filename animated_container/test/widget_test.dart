// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:animated_container_demo/main.dart';

void main() {
  testWidgets('renders and moves to next track', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AnimatedContainerDemoApp());

    // Verify initial UI is shown.
    expect(find.text('Music Player'), findsOneWidget);
    expect(find.text('Midnight Drive'), findsOneWidget);
    expect(find.text('Summer Bloom'), findsNothing);

    // Move to next track and allow the transition to settle.
    await tester.tap(find.byIcon(Icons.skip_next_rounded));
    await tester.pumpAndSettle();

    // Verify track changed.
    expect(find.text('Midnight Drive'), findsNothing);
    expect(find.text('Summer Bloom'), findsOneWidget);
  });
}
