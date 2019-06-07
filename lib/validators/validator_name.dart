import 'dart:async';

const String _kNameRule = r"^[a-zA-Z]";

class NameValidator {
  final StreamTransformer<String,String> validateName = StreamTransformer<String,String>.fromHandlers(handleData: (name, sink){
    final RegExp nameExp = new RegExp(_kNameRule);

    if (!nameExp.hasMatch(name) || name.isEmpty || name.length < 4){
      sink.addError('Ingrese un nombre valido');
    } else {
      sink.add(name);
    }
  });
}
