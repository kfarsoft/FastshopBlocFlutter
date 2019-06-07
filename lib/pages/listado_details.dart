import 'package:fastshop/blocs/home/listado_bloc.dart';
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


  ListDetailState({
    this.nombre,
    this.idListado,
  });

  @override
  void initState() {
    //Trae los productos del listado seleccionado
    blocCategoriesName.fetchAllCategories(idListado);
    super.initState();
  }

  @override
  void dispose() {
    blocCategoriesName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Text(nombre, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                  expandedHeight: 50.0,
                  floating: false,
                  backgroundColor: Colors.blueAccent,
                  pinned: true,
                  elevation: 0.0,
                ),
              ];
            },
            body: StreamBuilder(
              stream: blocCategoriesName.allTodoProductos,
              builder: (context,
                  AsyncSnapshot<List<ListCategory>> snapshotProducts) {
                if (snapshotProducts.hasData) {
                  return buildList(snapshotProducts);
                }
                else if (snapshotProducts.hasError) {
                  return Text('Error es:${snapshotProducts.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          margin: new EdgeInsets.only(bottom: 10.0),
        ),
      ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){deleteList();}, backgroundColor: Colors.red, icon: Icon(Icons.delete), label: Text('Eliminar'))
    );
  }


  Widget buildList(AsyncSnapshot<List<ListCategory>> snapshotProducts) {
    return ListView.builder(
        itemCount: snapshotProducts.data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: ListTile(
              title: Text(snapshotProducts.data[index].descripcion),
            ),
          );
        }
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
              onPressed: ()async {/*
                await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return DeleteList(
                        name: nombre,
                        idListado: idListado,
                        loginBloc: _loginBloc
                    );
                  }),);*/
                bloc.deleteListById(idListado);
                Navigator.of(context).pop(Navigator.pop(context));

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
}
