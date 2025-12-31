import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SubmitName extends AuthEvent {
  final String name;

  const SubmitName(this.name);

  @override
  List<Object?> get props => [name];
}

class SubmitMobile extends AuthEvent {
  final String mobile;

  const SubmitMobile(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

class SubmitOtp extends AuthEvent {
  final String otp;

  const SubmitOtp({required this.otp});

  @override
  List<Object?> get props => [otp];
}

class CheckAuth extends AuthEvent {} // app launch
class GoBackFromMobile extends AuthEvent {} // app launch
class GoBackFromOtp extends AuthEvent {} // app launch

class Logout extends AuthEvent {
  @override
  List<Object?> get props => [];
}
