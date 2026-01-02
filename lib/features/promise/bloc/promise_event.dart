import 'package:equatable/equatable.dart';

abstract class PromiseEvent extends Equatable {
  const PromiseEvent();

  @override
  List<Object?> get props => [];
}

class LoadContacts extends PromiseEvent {
  @override
  List<Object> get props => [];
}

class PickContactsTapped extends PromiseEvent {
  @override
  List<Object> get props => [];
}

class CheckPreviousLoad extends PromiseEvent {
  @override
  List<Object> get props => [];
}

class SearchContacts extends PromiseEvent {
  final String query;

  const SearchContacts(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSelectedPerson extends PromiseEvent {
  @override
  List<Object> get props => [];
}

class SetPromiseText extends PromiseEvent {
  final String text;

  const SetPromiseText(this.text);

  @override
  List<Object> get props => [text];
}

class SetPerson extends PromiseEvent {
  final String name;
  final String phone;

  const SetPerson(this.name, this.phone);

  @override
  List<Object> get props => [name, phone];
}

class SetDueDate extends PromiseEvent {
  final String dueAt;

  const SetDueDate(this.dueAt);

  @override
  List<Object> get props => [dueAt];
}

class SubmitPromise extends PromiseEvent {
  // final String text;
  // final String toPhone;
  // final String toName;
  // final DateTime dueAt;
  //
  // const SubmitPromise(this.text, this.toPhone, this.toName, this.dueAt);
  //
  // @override
  // List<Object> get props => [text, toPhone, toName, dueAt];
}
