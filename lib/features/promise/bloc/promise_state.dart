import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:kept_flutter/core/utils/api_constants.dart';
import 'package:kept_flutter/features/promise/data/model/promise_response.dart';
import 'package:kept_flutter/features/promise/data/model/recent_response_model.dart';

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
  final List<Contact> contacts; // all contacts
  final List<Contact> filteredContacts; // filtered contacts
  final List<ApiContact> recentContacts; // recent contacts horizontal

  // final Promise promise;

  const PromiseLoaded({
    this.contacts = const [],
    this.filteredContacts = const [],
    this.recentContacts = const [],
  });

  @override
  List<Object> get props => [contacts, filteredContacts, recentContacts];
}

class PromiseListLoaded extends PromiseState {
  final List<Promise>? promises;

  const PromiseListLoaded(this.promises);
}

class CreatePromiseSuccess extends PromiseState {
  const CreatePromiseSuccess();

  @override
  List<Object?> get props => [];
}

class ContactLoaded extends PromiseState {
  final List<Contact> contacts;

  const ContactLoaded(this.contacts);
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
