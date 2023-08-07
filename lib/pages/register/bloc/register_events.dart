abstract class RegisterEvent {
  const RegisterEvent();
}

class UserNameEvent extends RegisterEvent {
  final String userName;

  const UserNameEvent(
    this.userName,
  );
}

class UserEmailEvent extends RegisterEvent {
  final String email;

  const UserEmailEvent(
    this.email,
  );
}

class UserPasswordEvent extends RegisterEvent {
  final String password;

  const UserPasswordEvent(
    this.password,
  );
}

class UserRePasswordEvent extends RegisterEvent {
  final String rePassword;

  const UserRePasswordEvent(
    this.rePassword,
  );
}
