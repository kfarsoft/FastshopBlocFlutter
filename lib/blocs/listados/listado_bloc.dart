import 'package:fastshop/repos/listado_repository.dart';
import 'package:fastshop/models/models.dart';
import 'package:rxdart/rxdart.dart';

class ListBloc {

  final _listRepository = ListadoRepository();
  final _listFetcher = PublishSubject<List<Listado>>();
  final _categoriesFetcher = PublishSubject<List<ListCategory>>();
  //final _existCreateList = BehaviorSubject<List<Listado>>();
  //final _deleteTrue = BehaviorSubject<List<Listado>>();
  //final _title = BehaviorSubject<String>();
  //final _id = BehaviorSubject<String>();

  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<Listado>> get userListNames => _listFetcher.stream;

  Observable<List<ListCategory>> get listCategoryName => _categoriesFetcher.stream;

  //Observable<List<Listado>> get existList => _existCreateList.stream;
  //Function(String) get updateTitle => _title.sink.add;

  //Traemos los listados del usuario logueado
  fetchUserListNames(var user) async {
    List<Listado> list = await _listRepository.fetchListNames(user);
    _listFetcher.sink.add(list);
  }

  //Traemos las categorias del listado seleccionado
  fetchListCategories(var id) async {
    List<ListCategory> listCategories = await _listRepository.fetchListCategories(id);
    _categoriesFetcher.sink.add(listCategories);
  }
/*
  //Verificar si se creo la lisra
  fetchList(var idListado) async {
    List<Listado> listado = await _listRepository.fetchExistList(idListado);
    _existCreateList.sink.add(listado);
  }*/

  /*addSaveList(nombre, selected, user) async{
    List<Listado> listado = await _listRepository.addSaveList(nombre, selected, user);
    _existCreateList.sink.add(listado);
  }*/

//Borrar el listado por ID
  /*deleteListById(idListado) async{
    List<Listado> listado = await _listRepository.deleteList(idListado);
    _deleteTrue.sink.add(listado);
    _deleteTrue.drain();
  }*/

  /*updateInsert() {
    print(_id.value);
    _repository.updateTodo(_id.value);
  }*/

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async{
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    //_title.close();
    //_id.close();

    await _listFetcher.drain();
    _listFetcher.close();

    await _categoriesFetcher.drain();
    _categoriesFetcher.close();

    //await _existCreateList.drain();
    //_existCreateList.close();
    //_deleteTrue.drain();
    //_deleteTrue.close();
  }

  /*@override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;*/
}

//Manejamos para traer los listados del cliente
final bloc_user_list = ListBloc();

//-------------------------------------------------------------------------------------------
/*
class CategoryFromListBloc {
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
}*/

//Manejamos para traer los productos del listado seleccionado
//final bloc_category_names = CategoryFromListBloc();
