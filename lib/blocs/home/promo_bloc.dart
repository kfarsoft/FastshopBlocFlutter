import 'package:fastshop/models/models.dart';
import 'package:fastshop/repos/promo_repository.dart';
import 'package:rxdart/rxdart.dart';

class PromoBloc {
  final _repository = PromoRepository();
  final _todoFetcher = PublishSubject<List<Promocion>>();
  final _title = BehaviorSubject<String>();
  final _id = BehaviorSubject<String>();

  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<Promocion>> get allTodo => _todoFetcher.stream;
  Function(String) get updateTitle => _title.sink.add;
  Function(String) get getId => _id.sink.add;

  fetchAllTodo() async {
    List<Promocion> promocion = await _repository.fetchAllTodo();
    _todoFetcher.sink.add(promocion);
  }

  addSaveTodo() {
    _repository.addSaveTodo(_title.value);
  }

  updateTodo() {
    print(_id.value);
    _repository.updateSaveTodo(_id.value);
  }

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async{
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    _title.close();
    _id.close();
    await _todoFetcher.drain();
    _todoFetcher.close();
  }
}

final bloc = PromoBloc();
