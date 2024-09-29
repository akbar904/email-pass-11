
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/screens/login_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Cubit Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		blocTest<MockAuthCubit, AuthState>(
			'emits [AuthInitial, Authenticated] when signIn is successful',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.signIn('test@example.com', 'password123'),
			expect: () => [AuthInitial(), Authenticated()],
		);

		blocTest<MockAuthCubit, AuthState>(
			'emits [AuthInitial, Unauthenticated] when signIn fails',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.signIn('wrong@example.com', 'wrongpassword'),
			expect: () => [AuthInitial(), Unauthenticated()],
		);
	});

	group('LoginScreen Widget Tests', () {
		testWidgets('contains email and password text fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => MockAuthCubit(),
							child: LoginScreen(),
						),
					),
				),
			);

			expect(find.byType(CustomTextField), findsNWidgets(2));
			expect(find.byType(CustomButton), findsOneWidget);
		});

		testWidgets('displays error message on invalid login', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();

			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthInitial(), Unauthenticated()]),
				initialState: AuthInitial(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => mockAuthCubit,
							child: LoginScreen(),
						),
					),
				),
			);

			await tester.enterText(find.byType(CustomTextField).first, 'wrong@example.com');
			await tester.enterText(find.byType(CustomTextField).last, 'wrongpassword');
			await tester.tap(find.byType(CustomButton));
			await tester.pump();

			expect(find.text('Invalid email or password'), findsOneWidget);
		});
	});
}
