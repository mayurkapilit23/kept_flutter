import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/features/promise/bloc/promise_event.dart';
import 'package:kept_flutter/features/promise/bloc/promise_state.dart';

import '../data/repositories/get_contacts.dart';
import '../data/repositories/promise_repository.dart';

class PromiseBloc extends Bloc<PromiseEvent, PromiseState> {
  final PromiseRepository storage;

  PromiseBloc(this.storage) : super(PromiseInitial()) {
    on<CheckPreviousLoad>(_checkPreviousLoad);
    on<LoadContacts>(_loadContacts);
    on<SearchContacts>(_searchContacts);
  }

  void _checkPreviousLoad(
    CheckPreviousLoad event,
    Emitter<PromiseState> emit,
  ) async {
    final alreadyLoaded = await storage.isContactsLoaded();
    if (alreadyLoaded) {
      add(LoadContacts());
    }
  }

  //load contacts

  void _loadContacts(LoadContacts event, Emitter<PromiseState> emit) async {
    emit(PromiseLoading());
    try {
      final contacts = await getContacts();
      await storage.setContactsLoaded(true);
      emit(PromiseLoaded(contacts: contacts, filteredContacts: contacts));
    } catch (e) {
      emit(PromiseError(e.toString()));
    }
  }

  //search contacts

  void _searchContacts(event, emit) {
    if (state is PromiseLoaded) {
      final currentState = state as PromiseLoaded;
      final query = event.query.toLowerCase();

      final filtered = query.isEmpty
          ? currentState.contacts
          : currentState.contacts
                .where((c) => c.displayName.toLowerCase().contains(query))
                .toList();

      emit(
        PromiseLoaded(
          contacts: currentState.contacts,
          filteredContacts: filtered,
        ),
      );
    }
  }
}
