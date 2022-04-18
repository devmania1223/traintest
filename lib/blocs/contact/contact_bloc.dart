import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:educa_feedback/utils/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:educa_feedback/repositories/contact_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc({@required this.contactRepository})
      : assert(contactRepository != null),
        super(ContactState.empty());

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if (event is ContactSubmitEvent) {
      yield* _mapContactSubmitEventToState(event);
    } else if(event is ContactEmailChangedEvent) {
      yield* _mapEmailChangedEventToState(event.email);
    }
  }

  Stream<ContactState> _mapEmailChangedEventToState(String email) async*{
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<ContactState> _mapContactSubmitEventToState(
    ContactSubmitEvent event) async* {
    yield ContactState.loading();
    try {
      await contactRepository.addContact(
        // name: event.name,
        // email: event.email,
        subject: event.subject,
        description: event.description,
      );

      yield ContactState.success();
    } catch (e) {
      yield ContactState.failure();
    }
  }
}
