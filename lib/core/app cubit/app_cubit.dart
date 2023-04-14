import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nascon_security_app/core/app%20cubit/app_state.dart';
import 'package:nascon_security_app/models/user/user.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super(UnauthorizedAppState());
  late User user;

  login({required User user}){
    user = user;
    emit(AuthorizedAppState());
  }
}