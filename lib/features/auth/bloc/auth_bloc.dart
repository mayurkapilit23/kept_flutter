import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/features/auth/data/repositories/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  // 👈 store temporary user input
  String? _name;
  String? _mobile;

  AuthBloc(this.repository) : super(AuthInitial()) {
    log("AuthBloc CREATED");
    on<CheckAuth>(_onCheckStatus);
    on<SubmitName>(_onSubmitName);
    on<SubmitMobile>(_onSubmitMobile);
    on<SubmitOtp>(_onSubmitOtp);
    on<GoBackFromMobile>(goBackFromMobile);
    on<GoBackFromOtp>(goBackFromOtp);
    // on<Logout>(_onLogout);
  }

  Future<void> _onSubmitName(SubmitName event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // await repository.saveName(event.name);
    _name = event.name;
    emit(AuthInitial()); //move to mobile input
  }

  Future<void> _onSubmitMobile(
    SubmitMobile event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    debugPrint('From Bloc => authLoading completed');

    try {
      final payload = await repository.sendOtp(event.mobile);

      final message = payload['message'];
      debugPrint('submitMobile response => $message');

      _mobile = event.mobile;
      emit(OtpSent(event.mobile));
    } catch (e) {
      debugPrint('From Bloc => ${e.toString()}');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSubmitOtp(SubmitOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      if (_name == null || _mobile == null) {
        emit(AuthError("Name or mobile missing"));
        return;
      }

      final user = await repository.verifyOtp(
        phone: _mobile!,
        otp: event.otp,
        name: _name!,
      );
      emit(Authenticated(user!));
    } catch (e) {
      debugPrint('From Bloc ${e.toString()}');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckStatus(CheckAuth event, Emitter<AuthState> emit) async {
    final user = repository.getCachedUser();
    if (user != null && user.user != null) {
      emit(Authenticated(user.user));
    } else {
      emit(NameInputRequired());
    }
  }

  Future<void> goBackFromMobile(
    GoBackFromMobile event,
    Emitter<AuthState> emit,
  ) async {
    emit(NameInputRequired());
  }

  Future<void> goBackFromOtp(
    GoBackFromOtp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInitial());
  }
}
