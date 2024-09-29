
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_flutter_app/models/user.dart';

void main() {
	group('User Model Tests', () {
		test('User model serialization', () {
			final user = User(id: '123', email: 'test@example.com');
			final userJson = user.toJson();
			expect(userJson, {'id': '123', 'email': 'test@example.com'});
		});

		test('User model deserialization', () {
			final userJson = {'id': '123', 'email': 'test@example.com'};
			final user = User.fromJson(userJson);
			expect(user.id, '123');
			expect(user.email, 'test@example.com');
		});

		test('User model equality', () {
			final user1 = User(id: '123', email: 'test@example.com');
			final user2 = User(id: '123', email: 'test@example.com');
			expect(user1, equals(user2));
		});

		test('User model inequality', () {
			final user1 = User(id: '123', email: 'test@example.com');
			final user2 = User(id: '124', email: 'other@example.com');
			expect(user1, isNot(equals(user2)));
		});
	});
}

class User {
	final String id;
	final String email;

	User({required this.id, required this.email});

	Map<String, dynamic> toJson() => {
		'id': id,
		'email': email,
	};

	factory User.fromJson(Map<String, dynamic> json) => User(
		id: json['id'],
		email: json['email'],
	);

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is User &&
		runtimeType == other.runtimeType &&
		id == other.id &&
		email == other.email;

	@override
	int get hashCode => id.hashCode ^ email.hashCode;
}
