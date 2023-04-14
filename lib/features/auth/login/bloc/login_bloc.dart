import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nascon_security_app/core/app%20cubit/app_cubit.dart';
import 'package:nascon_security_app/core/form_submission_status.dart';
import 'package:nascon_security_app/features/auth/login/bloc/login_event.dart';
import 'package:nascon_security_app/features/auth/login/bloc/login_state.dart';
import 'package:nascon_security_app/models/user/user.dart';
import 'package:nascon_security_app/repos/auth_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authRepo, required this.appCubit})
      : super(LoginStateImp(formState: InitialFormSubmissionState())){
    on<UpdateEmail>(_updateEmail);
    on<UpdatePassword>(_updatePassword);
    on<LoginClicked>(_login);
  }

  AuthRepo authRepo;
  AppCubit appCubit;

  FutureOr<void> _updateEmail(UpdateEmail event, Emitter<LoginState> emit) {
    if(state is LoginStateImp){
      emit((state as LoginStateImp).copyWith(email: event.email));
    }
  }

  FutureOr<void> _updatePassword(UpdatePassword event, Emitter<LoginState> emit) {
    if(state is LoginStateImp) {
      emit((state as LoginStateImp).copyWith(password: event.password));
    }
  }

  FutureOr<void> _login(LoginClicked event, Emitter<LoginState> emit) async {
    if(state is LoginStateImp) {
      emit((state as LoginStateImp).copyWith(formState: LoadingFormSubmissionState()));

      try{
        String userId = await authRepo.login(email: (state as LoginStateImp).email,
            password: (state as LoginStateImp).password);

        emit((state as LoginStateImp).copyWith(formState: InitialFormSubmissionState()));
        User user = User(userId: userId, email: (state as LoginStateImp).email);
        appCubit.login(user: user);
      }
      catch (e){
        emit(ErrorLoginState(error: e.toString()));
        emit((LoginStateImp(formState: InitialFormSubmissionState())));
      }

    }
  }
}
