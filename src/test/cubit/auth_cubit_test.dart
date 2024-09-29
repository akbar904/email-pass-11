
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_flutter_app/cubit/auth_cubit.dart';
import 'package:my_flutter_app/cubit/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		test('initial state is AuthInitial', () {
			expect(authCubit.state, AuthInitial());
		});

		blocTest<AuthCubit, AuthState>(
			'signIn emits [Authenticated] when signIn is successful',
			build: () => authCubit,
			act: (cubit) => cubit.signIn('test@example.com', 'password'),
			expect: () => [Authenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'signOut emits [Unauthenticated] when signOut is called',
			build: () => authCubit,
			act: (cubit) => cubit.signOut(),
			expect: () => [Unauthenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'signIn emits [Unauthenticated] when signIn fails',
			build: () => authCubit,
			act: (cubit) => cubit.signIn('wrong@example.com', 'wrongpassword'),
			expect: () => [Unauthenticated()],
		);
	});
}
