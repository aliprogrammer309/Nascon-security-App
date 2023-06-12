import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nascon_security_app/core/app%20cubit/app_state.dart';
import 'package:nascon_security_app/models/user/user.dart';
import 'package:nascon_security_app/repos/auth_repo.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit({required this.authRepo}) : super(UnauthorizedAppState());
  late User user;
  AuthRepo authRepo;
  login({required User user, required String role}){
    user = user;
    if(role == 'security') {
      emit(SecurityAuthorizedAppState());
    }
    else{
      emit(FoodAuthorizedAppState());
    }
  }

  void logout() {
    emit(UnauthorizedAppState());
    authRepo.logout();
  }
}