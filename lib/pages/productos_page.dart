import 'package:fastshop/blocs/home/categoria_bloc.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/material.dart';

class ProductosPage extends StatefulWidget {
  ProductosPage({Key key}) : super(key: key);
  @override
  _ProductosPageState createState() => new _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {

  TextEditingController searchController = new TextEditingController();
  String filter;

  @override
  void initState() {
    bloc.fetchAllTodo();
    searchController.addListener((){
      setState(() {
        filter = searchController.text;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    searchController.dispose();
    bloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  labelText: "Buscar",
                  hintText: "Buscar",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
                  StreamBuilder(
                    stream: bloc.allTodo,
                    builder: (context, AsyncSnapshot<List<Categoria>> snapshot) {
                      if (snapshot.hasData) {
                        //Aca largamos la lista a la pantalla
                            return buildList(snapshot);
                        //return buildList(snapshot);
                      } else if (snapshot.hasError) {
                        return Text('Error es:${snapshot.error}');
                      }
                      return Center(child: CircularProgressIndicator());
                    }
                  ),
        ],
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<Categoria>> snapshot) {
    return new Expanded(
      child: ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return filter == null || filter == "" ? new ListTile(title: new
              Text(snapshot.data[index].descripcion)) : snapshot.data[index].descripcion.toLowerCase().contains(filter.toLowerCase()) ? new
            ListTile(title: new Text(snapshot.data[index].descripcion)) : new Container();
          },
      ),
    );
  }


}