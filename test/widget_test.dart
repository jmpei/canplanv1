// Smoke test: the app boots and lands on the dashboard.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:canplan_skeleton/main.dart';

void main() {
  testWidgets('App boots to the CanPlan dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const CanPlanApp());
    await tester.pumpAndSettle();

    expect(find.text('My Tasks'), findsOneWidget);
  });
}
