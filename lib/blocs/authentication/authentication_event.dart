import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:fastshop/bloc_helpers/bloc_event_state.dart';

abstract class AuthenticationEvent extends Equatable with BlocEvent {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String username;
  final String password;

  AuthenticationEventLogin({
    @required this.username,
    @required this.password,
  }) : super([username, password]);

}

class AuthenticationEventLogout extends AuthenticationEvent {}
