import 'package:nascon_security_app/models/user/user.dart';

abstract class AppState{}

class UnauthorizedAppState extends AppState{}

class AuthorizedAppState extends AppState{}