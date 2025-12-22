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

class PromiseLoaded extends PromiseState {
  final List<Contact> contacts;
  final List<Contact> filteredContacts;

  const PromiseLoaded({required this.contacts, required this.filteredContacts});

  @override
  List<Object> get props => [contacts, filteredContacts];
}

class PromiseError extends PromiseState {
  final String message;

  const PromiseError(this.message);

  @override
  List<Object> get props => [message];
}
