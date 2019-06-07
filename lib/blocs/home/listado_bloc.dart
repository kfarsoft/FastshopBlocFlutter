import 'package:fastshop/repos/listado_repository.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class ListadoBloc {
  final _repository = ListadoRepository();
  final _todoFetcher = PublishSubject<List<Listado>>();
  final _existCreateList = BehaviorSubject<List<Listado>>();
  final _deleteTrue = BehaviorSubject<List<Listado>>();
  final _title = BehaviorSubject<String>();
  final _id = BehaviorSubject<String>();

  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<Listado>> get allListNames => _todoFetcher.stream;
  Observable<List<Listado>> get existList => _existCreateList.stream;
  //Observable<List<Listado>> get getDeleteTrue => _deleteTrue.stream;
  Function(String) get updateTitle => _title.sink.add;
  //Function(String) get getId => _id.sink.add;

  //Traemos los datos de los listados por usuario
  fetchAllListados(var user) async {
    List<Listado> listado = await _repository.fetchAllTodo(user);
    _todoFetcher.sink.add(listado);
  }

  //Verificar si se creo la lisra
  fetchList(var idListado) async {
    List<Listado> listado = await _repository.fetchExistList(idListado);
    _existCreateList.sink.add(listado);
  }

  addSaveList(nombre, selected, user) async{
    List<Listado> listado = await _repository.addSaveList(nombre, selected, user);
    _existCreateList.sink.add(listado);
  }
//Borrar el listado por ID
  deleteListById(idListado) async{
    List<Listado> listado = await _repository.deleteList(idListado);
    _deleteTrue.sink.add(listado);
    _deleteTrue.drain();
  }

  /*updateInsert() {
    print(_id.value);
    _repository.updateTodo(_id.value);
  }*/

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async{
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    _title.close();
    _id.close();
    await _todoFetcher.drain();
    _todoFetcher.close();
    await _existCreateList.drain();
    _existCreateList.close();
    _deleteTrue.drain();
    _deleteTrue.close();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

//Manejamos para traer los listados del cliente
final bloc = ListadoBloc();

class ListadoCategoriesBloc {
  final _repository = ListadoRepository();
  final _todoFetcherCategories = PublishSubject<List<ListCategory>>();
  final _title = BehaviorSubject<String>();
  final _id = BehaviorSubject<String>();

  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<ListCategory>> get allTodoProductos => _todoFetcherCategories.stream;
  Function(String) get updateTitle => _title.sink.add;
  Function(String) get getId => _id.sink.add;


  fetchAllCategories(var id) async {
    List<ListCategory> listCategories = await _repository.fetchAllCategories(id);
    _todoFetcherCategories.sink.add(listCategories);
  }

  /*addSaveTodo() {
    _repository.addSaveTodo(_title.value);
  }

  updateTodo() {
    print(_id.value);
    _repository.updateSaveTodo(_id.value);
  }*/

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async{
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    _title.close();
    _id.close();
    await _todoFetcherCategories.drain();
    _todoFetcherCategories.close();
  }
}

//Manejamos para traer los productos del listado seleccionado
final blocCategoriesName = ListadoCategoriesBloc();
