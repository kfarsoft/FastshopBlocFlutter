import 'dart:async';

const String _kUsernameRule = r"^[a-zA-Z0-9]";

class UsernameValidator {
  final StreamTransformer<String,String> validateUsername = StreamTransformer<String,String>.fromHandlers(handleData: (username, sink){
    final RegExp usernameExp = new RegExp(_kUsernameRule);

    if (!usernameExp.hasMatch(username) || username.isEmpty || username.length < 4){
      sink.addError('Ingrese un usuario valido');
    } else {
      sink.add(username);
    }
  });
}
