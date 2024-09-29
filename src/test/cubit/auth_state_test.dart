
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:equatable/equatable.dart';
import 'package:com.example.my_flutter_app/lib/cubit/auth_state.dart';

void main() {
	group('AuthState', () {
		test('AuthState should extend Equatable', () {
			expect(AuthState(), isA<Equatable>());
		});

		test('AuthInitial should extend AuthState', () {
			expect(AuthInitial(), isA<AuthState>());
		});

		test('Authenticated should extend AuthState', () {
			expect(Authenticated(), isA<AuthState>());
		});

		test('Unauthenticated should extend AuthState', () {
			expect(Unauthenticated(), isA<AuthState>());
		});

		test('AuthInitial should have correct props', () {
			final state = AuthInitial();
			expect(state.props, []);
		});

		test('Authenticated should have correct props', () {
			final state = Authenticated();
			expect(state.props, []);
		});

		test('Unauthenticated should have correct props', () {
			final state = Unauthenticated();
			expect(state.props, []);
		});
	});
}
