import 'package:fastshop/bloc_widgets/bloc_state_builder.dart';
import 'package:fastshop/blocs/listados/listado_bloc.dart';
import 'package:fastshop/blocs/listados/listado_event.dart';
import 'package:fastshop/blocs/listados/listado_state.dart';
import 'package:fastshop/blocs/listados/listado_state_bloc.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/material.dart';

class ListDetail extends StatefulWidget {
  final nombre;
  final idListado;


  ListDetail({
    this.nombre,
    this.idListado,

  });

  @override
  State<StatefulWidget> createState() {
    return ListDetailState(
      nombre: nombre,
      idListado: idListado,
    );
  }
}

class ListDetailState extends State<ListDetail> {
  final nombre;
  final idListado;

  ListadoStateBloc _listadoStateBloc;


  ListDetailState({
    this.nombre,
    this.idListado,
  });

  @override
  void initState() {
    //Trae las categorias del listado seleccionado
    bloc_user_list.fetchListCategories(idListado);
    _listadoStateBloc = ListadoStateBloc();
    super.initState();
  }

  @override
  void dispose() {
    bloc_user_list.dispose();
    _listadoStateBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<ListadoState>(
        bloc: _listadoStateBloc,
        builder: (BuildContext context, ListadoState state) {
          if (state.isRunning) {
            return _buildNormal(context);
          } else if (state.isSuccess) {
            return _buildSuccess();
          } else if (state.isFailure) {
            return _buildFailure();
          }
          return _buildNormal(context);
        });

  }

  Widget _buildNormal(BuildContext context){
    return Scaffold(
        body: Container(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Text(nombre, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  expandedHeight: 5.0,
                  floating: false,
                  backgroundColor: Colors.blue,
                  pinned: false,
                  elevation: 0.0,
                ),
              ];
            },
            body: StreamBuilder(
              //El stream que contiene las categorias del listado ya seleccionado
              stream: bloc_user_list.listCategoryName,
              builder: (context,
                  AsyncSnapshot<List<ListCategory>> snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot);
                }
                else if (snapshot.hasError) {
                  return Text('Error es:${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          margin: new EdgeInsets.only(bottom: 10.0),
        ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){deleteList();}, backgroundColor: Colors.red, icon: Icon(Icons.delete), label: Text('Eliminar'))
    );
  }


  Widget buildList(AsyncSnapshot<List<ListCategory>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: ListTile(
              title: Text(snapshot.data[index].descripcion),
            ),
          );
        }
    );
  }

  Widget _buildSuccess() {
    return AlertDialog(
      title: Text('Exitoso'),
      content: const Text('El listado se ha eliminado con exito'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildFailure() {
    return AlertDialog(
      title: Text('Error'),
      content: const Text('Error en la eliminacion del listado'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  deleteList() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar listado'),
          content: Text(
              'Seguro quiere eliminar el listado ' + nombre + '?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Si'),
              onPressed: ()async {
                _deleteListById(idListado);
                Navigator.of(context).pop(context);
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteListById(idListado) {
    _listadoStateBloc.emitEvent(ListadoEvent(
      event: ListadoEventType.working,
      idList: idListado
    ));

    //bloc_user_list.deleteListById(idListado);
  }
}
