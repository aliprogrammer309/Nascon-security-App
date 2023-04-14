abstract class LoginEvent{}

class UpdateEmail extends LoginEvent{
  String email;

  UpdateEmail({required this.email});
}

class UpdatePassword extends LoginEvent{
  String password;

  UpdatePassword({required this.password});
}

class LoginClicked extends LoginEvent{}