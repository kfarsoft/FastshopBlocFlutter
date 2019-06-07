import 'package:fastshop/models/models.dart';
import 'package:fastshop/repos/categoria_repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoriaBloc {
  final _repository = CategoriaRepository();
  final _todoFetcher = PublishSubject<List<Categoria>>();
  final _title = BehaviorSubject<String>();
  final _id = BehaviorSubject<String>();

  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<Categoria>> get allTodo => _todoFetcher.stream;
  Function(String) get updateTitle => _title.sink.add;
  Function(String) get getId => _id.sink.add;

  fetchAllTodo() async {
    List<Categoria> categoria = await _repository.fetchAllTodo();
    _todoFetcher.sink.add(categoria);
  }

  addSaveTodo() {
    _repository.addSaveTodo(_title.value);
  }

  /* updateTodo() {
    print(_id.value);
    _repository.updateSaveTodo(_id.value);
  }*/

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async{
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    _title.close();
    _id.close();
    await _todoFetcher.drain();
    _todoFetcher.close();
  }
}

final bloc = CategoriaBloc();
