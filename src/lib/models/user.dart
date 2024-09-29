
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
