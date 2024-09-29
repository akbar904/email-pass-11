
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/auth_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MainApp());
}

class MainApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider<AuthCubit>(
			create: (context) => AuthCubit(),
			child: MaterialApp(
				home: AuthListener(),
			),
		);
	}
}

class AuthListener extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AuthCubit, AuthState>(
			builder: (context, state) {
				if (state is Authenticated) {
					return HomeScreen();
				} else {
					return LoginScreen();
				}
			},
		);
	}
}
