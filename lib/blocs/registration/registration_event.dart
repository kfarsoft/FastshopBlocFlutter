import 'package:fastshop/bloc_helpers/bloc_event_state.dart';

class RegistrationEvent extends BlocEvent {
  RegistrationEvent({
    this.event,
    this.username,
    this.name,
    this.lastname,
    this.email,
    this.password,
    this.doc,
  });

  final RegistrationEventType event;
  final String username;
  final String name;
  final String lastname;
  final String email;
  final String password;
  final String doc;
}

enum RegistrationEventType {
  none,
  working,
}