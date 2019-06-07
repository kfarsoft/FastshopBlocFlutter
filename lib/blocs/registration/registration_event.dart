import 'package:fastshop/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';

class RegistrationEvent extends BlocEvent {

  final RegistrationEventType event;
  final String username;
  final String email;
  final String password;

  RegistrationEvent({
    @required this.event,
    @required this.username,
    @required this.email,
    @required this.password,
  });

}

enum RegistrationEventType {
  none,
  working,
}