import 'package:fastshop/functions/getUsername.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fastshop/blocs/listados/listado_bloc.dart';

import 'package:fastshop/pages/listados/listado_details.dart';

class LisCompra extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListadoComprasState();
  }
}

class ListadoComprasState extends State<LisCompra> {
  var user;

  Future<void> fetchUserListNames() async {
    user = await getUsername();
    await bloc_user_list.fetchUserListNames(user);
  }

  @override
  void initState() {
    super.initState();
    //Trae solamente los nombres de los listados
    fetchUserListNames();
  }

  @override
  void dispose() {
    bloc_user_list.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //Estamos escuchando al stream,
      //cuando el valor sale afuera del stream largamos la lista por pantalla
      stream: bloc_user_list.userListNames,
      builder: (context, AsyncSnapshot<List<Listado>> snapshot) {
        if (snapshot.hasData) {
          //Aca largamos la lista a la pantalla
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text('Error es:${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator());
      },
    );
    //floatingActionButton: FloatingActionButton.extended(onPressed: null, backgroundColor: Colors.blueAccent, icon: Icon(Icons.add), label: Text('Nuevo'))
  }

  Widget buildList(AsyncSnapshot<List<Listado>> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
            enableFeedback: true,
            child: Card(
              child: new Stack(
                children: <Widget>[
                  //new Image.network(snapshot.data[index].uri, fit: BoxFit.cover),
                  Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                      child: new Text(snapshot.data[index].nombre,
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold))),
                ],
              ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
            ),
            //onTap: () => openDetailListPage(snapshot.data, index),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListDetail(
                      nombre: snapshot.data[index].nombre,
                      idListado: snapshot.data[index].idListado),
                ),
              );
            });
      },
    );
  }
}
