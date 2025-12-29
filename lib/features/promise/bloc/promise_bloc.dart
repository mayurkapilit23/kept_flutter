import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:kept_flutter/features/promise/bloc/promise_event.dart';
import 'package:kept_flutter/features/promise/bloc/promise_state.dart';
import 'package:uuid/uuid.dart';

import '../data/model/promise.dart';
import '../data/repositories/get_contacts.dart';
import '../data/repositories/promise_repository.dart';

class PromiseBloc extends Bloc<PromiseEvent, PromiseState> {
  final PromiseRepository storage;

  // Promise promise = Promise(
  //   id: Uuid().v4(),
  //   text: "",
  //   toName: "",
  //   toPhone: "",
  //   createdAt: DateTime.now(),
  //   dueAt: DateTime.now(),
  //   isDone: false,
  // );

  PromiseBloc(this.storage) : super(PromiseInitial()) {
    log('🔥 PromiseBloc CREATED $hashCode');
    on<CheckPreviousLoad>(_checkPreviousLoad);
    // on<PickContactsTapped>((event, emit) {
    //   emit(PromiseLoading());
    //   add(LoadContacts());
    // });

    on<ClearSelectedPerson>((event, emit) {
      if (state is! PromiseLoaded) return;

      final current = state as PromiseLoaded;

      emit(
        PromiseLoaded(
          contacts: current.contacts,
          filteredContacts: current.filteredContacts,
          promise: current.promise.copyWith(
            toName: '',
            toPhone: '',
          ),
        ),
      );
    });

    on<LoadContacts>(_loadContacts);
    on<SearchContacts>(_searchContacts);
    on<SetPromiseText>(_onSetPromiseText);
    on<SetPerson>(_setPerson);
  }

  //Check previous load
  Future<void> _checkPreviousLoad(
    CheckPreviousLoad event,
    Emitter<PromiseState> emit,
  ) async {
    final alreadyLoaded = await storage.isContactsLoaded();
    if (alreadyLoaded) {
      add(LoadContacts());
    }
    else {
      emit(PromiseInitial());
    }
  }

  //load contacts
  Future<void> _loadContacts(
    LoadContacts event,
    Emitter<PromiseState> emit,
  ) async {
    // log('Before Promise Loading =>   $promise.text');
    emit(PromiseLoading());
    try {
      final contacts = await getContacts();
      await storage.setContactsLoaded(true);
      final existingPromise = state is PromiseLoaded
          ? (state as PromiseLoaded).promise
          : _createEmptyPromise();

      emit(
        PromiseLoaded(
          contacts: contacts,
          filteredContacts: contacts,
          promise: existingPromise, // ✅ KEEP TEXT
        ),
      );
    } catch (e) {
      emit(PromiseError(message: e.toString()));
    }
  }

  //search contacts

  void _searchContacts(SearchContacts event, Emitter<PromiseState> emit) {
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
        promise: currentState.promise,
      ),
    );
  }

  void _onSetPromiseText(SetPromiseText event, Emitter<PromiseState> emit) {
    // log("_onSetPromiseText  state =>  ${state}");
    // final current = state as PromiseLoaded;
    // log("after _onSetPromiseText  state =>  ${state}");
    //
    // log('Set Promise');
    // // log("Person id => ${promise.id}");
    // // log("Promise Text => ${promise.text}");
    // // log("Person Name => ${promise.toName}");
    // // log("Person Phone => ${promise.toPhone}");
    //
    // // promise.text = event.text;
    // final updatedPromise = current.promise.copyWith(
    //   text: event.text,
    // );
    //
    // emit(
    //   PromiseLoaded(
    //     contacts: current.contacts,
    //     filteredContacts: current.filteredContacts,
    //     promise: updatedPromise,
    //   ),
    // );

    Promise currentPromise;
    List<Contact> contacts = [];
    List<Contact> filteredContacts = [];

    if (state is PromiseLoaded) {
      final loaded = state as PromiseLoaded;
      currentPromise = loaded.promise;
      contacts = loaded.contacts;
      filteredContacts = loaded.filteredContacts;
    } else {
      currentPromise = _createEmptyPromise();
    }

    emit(
      PromiseLoaded(
        contacts: contacts,
        filteredContacts: filteredContacts,
        promise: currentPromise.copyWith(text: event.text),
      ),
    );
  }

  // Set selected person
  void _setPerson(SetPerson event, Emitter<PromiseState> emit) {
    if (state is! PromiseLoaded) return;
    final current = state as PromiseLoaded;
    log('Set Person');
    // log("Person id => ${promise.id}");
    // log("Promise Text => ${promise.text}");
    // log("Person Name => ${promise.toName}");
    // log("Person Phone => ${promise.toPhone}");

    emit(
      PromiseLoaded(
        contacts: current.contacts,
        filteredContacts: current.filteredContacts,
        promise: current.promise.copyWith(
          toName: event.name,
          toPhone: event.phone,
        ),
      ),
    );
  }

  Promise _createEmptyPromise() {
    return Promise(
      id: const Uuid().v4(),
      text: '',
      toName: '',
      toPhone: '',
      createdAt: DateTime.now(),
      dueAt: DateTime.now(),
      isDone: false,
    );
  }
}
