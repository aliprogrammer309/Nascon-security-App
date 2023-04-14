import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nascon_security_app/core/app%20cubit/app_cubit.dart';
import 'package:nascon_security_app/core/form_submission_status.dart';
import 'package:nascon_security_app/features/home/user%20details/bloc/user_details_event.dart';
import 'package:nascon_security_app/features/home/user%20details/bloc/user_details_state.dart';
import 'package:nascon_security_app/models/events/user_event.dart';
import 'package:nascon_security_app/repos/home_repo.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc(
      {required this.appCubit, required this.homeRepo, required this.id})
      : super(UserDetailsStateImp(formState: InitialFormSubmissionState())) {
    on<FetchUserDetails>(_fetchUserDetails);
  }

  AppCubit appCubit;
  HomeRepo homeRepo;
  String id;

  FutureOr<void> _fetchUserDetails(
      FetchUserDetails event, Emitter<UserDetailsState> emit) async {
    if (state is UserDetailsStateImp) {
      try {
        emit((state as UserDetailsStateImp)
            .copyWith(formState: LoadingFormSubmissionState()));
        List<UserEvent> events = await homeRepo.getUserDetails(id: id);

        emit((state as UserDetailsStateImp)
            .copyWith(formState: InitialFormSubmissionState(), events: events));
      } catch (e) {
        emit((state as UserDetailsStateImp)
            .copyWith(formState: InitialFormSubmissionState()));
      }
    }
  }
}
