import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nascon_security_app/core/app%20cubit/app_cubit.dart';
import 'package:nascon_security_app/core/form_submission_status.dart';
import 'package:nascon_security_app/features/home/food%20details/bloc/food_details_event.dart';
import 'package:nascon_security_app/features/home/food%20details/bloc/food_details_state.dart';
import 'package:nascon_security_app/models/events/user_event.dart';
import 'package:nascon_security_app/repos/home_repo.dart';

class FoodDetailsBloc extends Bloc<FoodDetailsEvent, FoodDetailsState>{
  FoodDetailsBloc({required this.appCubit, required this.homeRepo, required this.id}) : super(FoodDetailsStateImp(formState: InitialFormSubmissionState())){
    on<FetchFoodDetails>(_fetchFoodDetails);
  }

  AppCubit appCubit;
  HomeRepo homeRepo;
  String id;

  FutureOr<void> _fetchFoodDetails(FetchFoodDetails event, Emitter<FoodDetailsState> emit) async {
    if (state is FoodDetailsStateImp) {
      try {
        emit((state as FoodDetailsStateImp)
            .copyWith(formState: LoadingFormSubmissionState()));
        UserEvent details = await homeRepo.getFoodDetails(id: id);

        emit((state as FoodDetailsStateImp)
            .copyWith(formState: InitialFormSubmissionState(), events: details)); // comp

      } catch (e) {
        emit((state as FoodDetailsStateImp)
            .copyWith(formState: InitialFormSubmissionState()));
      }
    }
  }
}