
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_flutter_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  group('Main App Tests', () {
    late AuthCubit authCubit;

    setUp(() {
      authCubit = MockAuthCubit();
    });

    testWidgets('App initializes with LoginScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (_) => authCubit,
            child: MainApp(),
          ),
        ),
      );
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('Navigates to HomeScreen when Authenticated state is emitted', (WidgetTester tester) async {
      whenListen(
        authCubit,
        Stream.fromIterable([Authenticated()]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (_) => authCubit,
            child: MainApp(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Navigates to LoginScreen when Unauthenticated state is emitted', (WidgetTester tester) async {
      whenListen(
        authCubit,
        Stream.fromIterable([Unauthenticated()]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (_) => authCubit,
            child: MainApp(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
