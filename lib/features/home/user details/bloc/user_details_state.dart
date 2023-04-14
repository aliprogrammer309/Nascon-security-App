import 'package:nascon_security_app/core/form_submission_status.dart';
import 'package:nascon_security_app/models/events/user_event.dart';

abstract class UserDetailsState {}

class ErrorUserDetailsState extends UserDetailsState {
  String error;

  ErrorUserDetailsState({required this.error});
}

class UserDetailsStateImp extends UserDetailsState {
  FormSubmissionState formState;
  List<UserEvent>? events;

  UserDetailsStateImp({
    required this.formState,
    this.events,
  });

  UserDetailsStateImp copyWith({
    FormSubmissionState? formState,
    List<UserEvent>? events,
  }) {
    return UserDetailsStateImp(
      formState: formState ?? this.formState,
      events: events ?? this.events,
    );
  }
}
