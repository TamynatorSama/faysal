 import 'package:firebase_core/firebase_core.dart';

Map<String, AuthError> authErrorMapping= {
  "user-not-found" : UserNotFound(),
  "weak-password": WeakPassword(),
  "invalid-email":WeakPassword(),
  "operation-not-allowed":InvalidOperation(),
  "email-already-in-use":EmailAlready(),
  "requires-recent-login": RequiresRecentLogin(),
  "no-current-user": NoCurrentUser()
};

abstract class AuthError{
  final String message;
  AuthError({required this.message});
  factory AuthError.from(FirebaseException exception)=>
  authErrorMapping[exception.code.toLowerCase().trim()] ?? UnrecognisedError(); 
}


class UnrecognisedError extends AuthError{
  UnrecognisedError({super.message = "Unknown authentication error"});
}

class UserNotFound extends AuthError{
  UserNotFound({super.message = "Invalid email or password"});
}

class EmailAlready extends AuthError{
  EmailAlready({super.message = "Email already in use"});
}

class InvalidOperation extends AuthError{
  InvalidOperation({super.message = "This opeation is not allowed"});
}

class NoCurrentUser extends AuthError{
  NoCurrentUser({super.message = "User currently logged out"});
}

class RequiresRecentLogin extends AuthError{
  RequiresRecentLogin({super.message = "Expired token, login and try again"});
}


class WeakPassword extends AuthError{
  WeakPassword({super.message = "Provide a stronger password that cannot be easily guessed"});
}