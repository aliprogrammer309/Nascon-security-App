class User {
  String userId;
  String email;

  User({required this.userId, required this.email});

  User copyWith({
    String? userId,
    String? email,
  }) {
    return User(
      userId: userId ?? this.userId,
      email: email?? this.email,
    );
  }
}
