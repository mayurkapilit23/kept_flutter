import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/features/promise/bloc/promise_event.dart';
import 'package:kept_flutter/features/promise/bloc/promise_state.dart';

import '../data/model/promise_request.dart';
import '../data/repositories/get_contacts.dart';
import '../data/repositories/promise_repository.dart';

class PromiseBloc extends Bloc<PromiseEvent, PromiseState> {
  final PromiseRepository promiseRepo;
  final promiseModel = PromiseRequest();

  PromiseBloc(this.promiseRepo) : super(PromiseInitial()) {
    on<CheckPreviousLoad>(_checkPreviousLoad);
    on<LoadContacts>(_loadContacts);
    on<SearchContacts>(_searchContacts);
    on<SetPromiseText>(_onPromiseText);
    on<SetPerson>(_setPerson);
    on<SubmitPromise>(_onSubmitPromise);

    on<SetDueDate>((event, emit) {
      // final updatedPromise = state.promise.copyWith(
      //   dueAt: event.dueAt,
      // );
      final current = state as PromiseLoaded;

      emit(
        PromiseLoaded(
          contacts: current.contacts,
          filteredContacts: current.filteredContacts,
        ),
      );
    });
  }

  void _checkPreviousLoad(
    CheckPreviousLoad event,
    Emitter<PromiseState> emit,
  ) async {
    final alreadyLoaded = await promiseRepo.isContactsLoaded();
    if (alreadyLoaded) {
      add(LoadContacts());
    }
  }

  //load contacts

  void _loadContacts(LoadContacts event, Emitter<PromiseState> emit) async {
    emit(PromiseLoading());
    try {
      final contacts = await getContacts();
      await promiseRepo.setContactsLoaded(true);

      emit(PromiseLoaded(contacts: contacts, filteredContacts: contacts));
    } catch (e) {
      emit(PromiseError(message: e.toString()));
    }
  }

  //search contacts

  void _searchContacts(SearchContacts event, Emitter<PromiseState> emit) {
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

  void _onPromiseText(SetPromiseText event, Emitter<PromiseState> emit) {
    if (state is! PromiseLoaded) return;

    final current = state as PromiseLoaded;

    // final updatedPromise = current.promise.copyWith(text: event.text);
    emit(
      PromiseLoaded(
        contacts: current.contacts,
        filteredContacts: current.filteredContacts,
      ),
    );
  }

  void _setPerson(SetPerson event, Emitter<PromiseState> emit) {
    if (state is! PromiseLoaded) return;

    final current = state as PromiseLoaded;

    emit(
      PromiseLoaded(
        contacts: current.contacts,
        filteredContacts: current.filteredContacts,
      ),
    );
  }

  Future<void> _onSubmitPromise(
    SubmitPromise event,
    Emitter<PromiseState> emit,
  ) async {
    emit(PromiseLoading());

    if (promiseModel.text == null ||
        promiseModel.toName == null ||
        promiseModel.toPhone == null ||
        promiseModel.dueAt == null) {
      emit(PromiseError(message: "All fields are required"));
      final test = state is PromiseError;
      debugPrint('PromiseErrorState => $test');
    }

    final promiseResponse = await promiseRepo.createPromise(
      text: promiseModel.text!,
      toPhone: promiseModel.toPhone!,
      toName: promiseModel.toName!,
      dueAt: promiseModel.dueAt.toString(),
    );
    emit(CreatePromiseSuccess());

    debugPrint('PromiseCreated with ID : ${promiseResponse.promise?.id}');
  }
}
