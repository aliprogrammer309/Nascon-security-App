abstract class HomeState{}

class ErrorHomeState extends HomeState{
  String error;

  ErrorHomeState({required this.error});
}

class HomeStateImp extends HomeState{}