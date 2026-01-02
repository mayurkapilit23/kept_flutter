import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/contact.dart';

abstract class PromiseState extends Equatable {
  const PromiseState();

  @override
  List<Object?> get props => [];
}

class PromiseInitial extends PromiseState {
  @override
  List<Object> get props => [];
}

class PromiseLoading extends PromiseState {
  @override
  List<Object> get props => [];
}

class PromiseTextSet extends PromiseState {
  @override
  List<Object> get props => [];
}

class PromiseLoaded extends PromiseState {
  final List<Contact> contacts;
  final List<Contact> filteredContacts;

  // final Promise promise;

  const PromiseLoaded({
    // required this.promise,
    this.contacts = const [],
    this.filteredContacts = const [],
  });

  @override
  List<Object> get props => [contacts, filteredContacts];
}

class CreatePromiseSuccess extends PromiseState {
  const CreatePromiseSuccess();

  @override
  List<Object?> get props => [];
}

class NavigateToSelectPerson extends PromiseState {
  const NavigateToSelectPerson();

  @override
  List<Object?> get props => [];
}

class PromiseError extends PromiseState {
  final String message;

  const PromiseError({required this.message});

  @override
  List<Object> get props => [message];
}
