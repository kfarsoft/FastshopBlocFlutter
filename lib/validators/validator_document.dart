import 'dart:async';

const String _kDocumentRule = r"^[0-9]";

class DocumentValidator {
  final StreamTransformer<String,String> validateDocument = StreamTransformer<String,String>.fromHandlers(handleData: (doc, sink){
    final RegExp docExp = new RegExp(_kDocumentRule);

    if (!docExp.hasMatch(doc) || doc.isEmpty || doc.length != 8 ){
      sink.addError('Ingrese un documento valido');
    } else {
      sink.add(doc);
    }
  });
}
