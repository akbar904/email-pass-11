
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
	@override
	_LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocListener<AuthCubit, AuthState>(
				listener: (context, state) {
					if (state is Authenticated) {
						Navigator.pushReplacementNamed(context, '/home');
					} else if (state is Unauthenticated) {
						ScaffoldMessenger.of(context).showSnackBar(
							SnackBar(content: Text('Invalid email or password')),
						);
					}
				},
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							CustomTextField(
								hintText: 'Email',
								controller: _emailController,
							),
							SizedBox(height: 16.0),
							CustomTextField(
								hintText: 'Password',
								controller: _passwordController,
							),
							SizedBox(height: 16.0),
							CustomButton(
								label: 'Login',
								onPressed: () {
									final email = _emailController.text;
									final password = _passwordController.text;
									context.read<AuthCubit>().signIn(email, password);
								},
							),
						],
					),
				),
			),
		);
	}
}
