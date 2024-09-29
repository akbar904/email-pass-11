
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void signIn(String email, String password) async {
		try {
			// Simulate an authentication process
			await Future.delayed(Duration(seconds: 1));
			if (email == 'test@example.com' && password == 'password') {
				emit(Authenticated());
			} else {
				emit(Unauthenticated());
			}
		} catch (_) {
			emit(Unauthenticated());
		}
	}

	void signOut() {
		emit(Unauthenticated());
	}
}
