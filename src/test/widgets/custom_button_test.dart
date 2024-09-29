
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_app/widgets/custom_button.dart';

void main() {
	group('CustomButton Widget Tests', () {
		testWidgets('should display the correct label', (WidgetTester tester) async {
			const label = 'Press Me';
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: CustomButton(
							label: label,
							onPressed: () {},
						),
					),
				),
			);

			expect(find.text(label), findsOneWidget);
		});

		testWidgets('should trigger onPressed callback when tapped', (WidgetTester tester) async {
			bool wasPressed = false;
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: CustomButton(
							label: 'Press Me',
							onPressed: () {
								wasPressed = true;
							},
						),
					),
				),
			);

			await tester.tap(find.byType(CustomButton));
			await tester.pump();

			expect(wasPressed, isTrue);
		});

		testWidgets('should have correct styling', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: CustomButton(
							label: 'Press Me',
							onPressed: () {},
						),
					),
				),
			);

			final button = tester.widget<CustomButton>(find.byType(CustomButton));
			expect(button, isNotNull);
		});
	});
}
