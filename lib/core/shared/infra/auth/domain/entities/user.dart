class User {
  const User({
    required this.id,
    required this.username,
    required this.password,
    required this.details,
  });

  final int id;
  final String username;
  final String password;
  final Details details;
}

class Details {
  const Details({
    required this.firstname,
    required this.lastname,
    required this.balance,
    required this.mobile,
  });

  final String firstname;
  final String lastname;
  final double balance;
  final String mobile;

  // Computed properties
  String get fullName => '$firstname $lastname'.trim();
}
