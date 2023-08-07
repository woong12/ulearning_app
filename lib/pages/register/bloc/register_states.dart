class RegisterStates {
  final String userName;
  final String email;
  final String password;
  final String rePassword;

  const RegisterStates(
    this.userName,
    this.email,
    this.password,
    this.rePassword,
  );

  RegisterStates copyWith({
    String? userName,
    String? email,
    String? password,
    String? rePassword,
  }) {
    return RegisterStates(
      userName ?? this.userName,
      email ?? this.email,
      password ?? this.password,
      rePassword ?? this.password,
    );
  }
}
// thread safe