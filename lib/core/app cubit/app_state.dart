import 'package:nascon_security_app/models/user/user.dart';

abstract class AppState{}

class UnauthorizedAppState extends AppState{}

abstract class AuthorizedAppState extends AppState{}

class SecurityAuthorizedAppState extends AuthorizedAppState{}

class FoodAuthorizedAppState extends AuthorizedAppState{}