import 'dart:async';

const String _kLastNameRule = r"^[a-zA-Z]";

class LastnameValidator {
  final StreamTransformer<String,String> validateName = StreamTransformer<String,String>.fromHandlers(handleData: (lastName, sink){
    final RegExp lastNameExp = new RegExp(_kLastNameRule);

    if (!lastNameExp.hasMatch(lastName) || lastName.isEmpty || lastName.length < 3){
      sink.addError('Ingrese un Apellido valido');
    } else {
      sink.add(lastName);
    }
  });
}
