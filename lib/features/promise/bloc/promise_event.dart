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
