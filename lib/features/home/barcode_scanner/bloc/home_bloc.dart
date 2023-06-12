import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nascon_security_app/core/app%20cubit/app_cubit.dart';
import 'package:nascon_security_app/features/home/barcode_scanner/bloc/home_event.dart';
import 'package:nascon_security_app/features/home/barcode_scanner/bloc/home_state.dart';
import 'package:nascon_security_app/repos/home_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc({required this.appCubit, required this.homeRepo}) : super(HomeStateImp()){
    on<Logout>(logout);
  }

  AppCubit appCubit;
  HomeRepo homeRepo;

  FutureOr<void> logout(Logout event, Emitter<HomeState> emit) {
    appCubit.logout();
  }
}