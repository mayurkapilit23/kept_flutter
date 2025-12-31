import 'package:equatable/equatable.dart';

import '../data/model/user.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class NameInputRequired extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class OtpSent extends AuthState {
  final String phone;

  OtpSent(this.phone);

  @override
  List<Object?> get props => [phone];
}

class Authenticated extends AuthState {
  final User? user;
  Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class OtpRequested extends AuthState {
  OtpRequested();

  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
