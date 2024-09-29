
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_app/widgets/custom_text_field.dart';

void main() {
	group('CustomTextField Widget Tests', () {
		testWidgets('displays hint text', (WidgetTester tester) async {
			// Arrange
			const hintText = 'Enter your email';
			final controller = TextEditingController();

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: CustomTextField(
							hintText: hintText,
							controller: controller,
						),
					),
				),
			);

			// Assert
			expect(find.text(hintText), findsOneWidget);
		});

		testWidgets('uses provided TextEditingController', (WidgetTester tester) async {
			// Arrange
			const hintText = 'Enter your password';
			final controller = TextEditingController();

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: CustomTextField(
							hintText: hintText,
							controller: controller,
						),
					),
				),
			);

			// Enter text
			await tester.enterText(find.byType(TextField), 'password123');

			// Assert
			expect(controller.text, 'password123');
		});

		testWidgets('renders TextField with correct properties', (WidgetTester tester) async {
			// Arrange
			const hintText = 'Enter something';
			final controller = TextEditingController();

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: CustomTextField(
							hintText: hintText,
							controller: controller,
						),
					),
				),
			);

			// Assert
			final textField = tester.widget<TextField>(find.byType(TextField));
			expect(textField.controller, controller);
			expect(textField.decoration?.hintText, hintText);
		});
	});
}
