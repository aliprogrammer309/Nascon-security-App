import 'package:nascon_security_app/core/form_submission_status.dart';

abstract class LoginState {}

class ErrorLoginState extends LoginState {
  String error;

  ErrorLoginState({required this.error});
}

class LoginStateImp extends LoginState {
  String email;
  String password;
  FormSubmissionState formState;

  LoginStateImp({
    this.email = '',
    this.password = '',
    required this.formState,
  });

  LoginStateImp copyWith({
    String? email,
    String? password,
    FormSubmissionState? formState,
  }) {
    return LoginStateImp(
      email: email ?? this.email,
      password: password ?? this.password,
      formState: formState ?? this.formState,
    );
  }
}
