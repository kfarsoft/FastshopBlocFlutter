import 'dart:async';
import 'package:fastshop/models/models.dart';
import 'package:fastshop/repos/listado_provider.dart';

class ListadoRepository{

  //---------------LISTADOS------------------------------------------
  //final title = '';
  final listadoProvider = ListadoProvider();

  Future<List<Listado>> fetchAllTodo(user) => listadoProvider.fetchTodoListName(user);
  Future<List<Listado>> fetchExistList(idListado) => listadoProvider.fetchExistList(idListado);
  Future<List<ListCategory>> fetchAllCategories(id) => listadoProvider.fetchTodoListCategory(id);
  Future<List<Listado>> addSaveList(String nombre, List<Categoria> selected, var user) => listadoProvider.addList(nombre, selected, user);
  //Borrar el listado por ID
  Future<List<Listado>> deleteList(idListado) => listadoProvider.deleteList(idListado);
//Future updateTodo(String ids) => listadoProvider.updateInsert(ids);

//---------------LISTADOS------------------------------------------

}