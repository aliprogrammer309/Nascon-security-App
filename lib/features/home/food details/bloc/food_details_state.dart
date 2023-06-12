import 'package:nascon_security_app/core/form_submission_status.dart';
import 'package:nascon_security_app/models/events/user_event.dart';

abstract class FoodDetailsState {}

class ErrorFoodDetailsState extends FoodDetailsState {
  String error;

  ErrorFoodDetailsState({required this.error});
}

class FoodDetailsStateImp extends FoodDetailsState {
  FormSubmissionState formState;
  UserEvent? events;

  FoodDetailsStateImp({
    required this.formState,
    this.events,
  });

  FoodDetailsStateImp copyWith({
    FormSubmissionState? formState,
    UserEvent? events,
  }) {
    return FoodDetailsStateImp(
      formState: formState ?? this.formState,
      events: events ?? this.events,
    );
  }
}
