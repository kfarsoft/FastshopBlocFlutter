import 'package:fastshop/bloc_widgets/bloc_state_builder.dart';
import 'package:fastshop/blocs/listados/listado_event.dart';
import 'package:fastshop/blocs/listados/listado_save_bloc.dart';
import 'package:fastshop/blocs/listados/listado_state.dart';
import 'package:fastshop/functions/getUsername.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/material.dart';

class NewListDetails extends StatefulWidget {
  final List<Categoria> selected;

  NewListDetails({
    this.selected,
  });

  @override
  State<StatefulWidget> createState() {
    return NewListDetailsState(
      selected: selected,
    );
  }
}

class NewListDetailsState extends State<NewListDetails> {
  final List<Categoria> selected;
  TextEditingController listNameController = new TextEditingController();
  String msg='';
  ListSaveBloc _listStateBloc;

  var user;
  Future<void> _getUsername() async {
    user = await getUsername();
  }

  NewListDetailsState({
    this.selected,
  });

  @override
  void initState() {
    _getUsername();
    _listStateBloc = ListSaveBloc();
    super.initState();
  }

  @override
  void dispose() {
    _listStateBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<ListadoState>(
        bloc: _listStateBloc,
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
        body: SafeArea(
          top: false,
          bottom: true,
          child: Container(
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: Text('Nuevo listado', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                    expandedHeight: 50.0,
                    floating: false,
                    backgroundColor: Colors.blueAccent,
                    pinned: true,
                    elevation: 0.0,
                  ),
                ];
              },
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    child: TextField(
                      controller: listNameController,
                      decoration: InputDecoration(
                          hintText: "Ingrese nombre del listado",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                    ),
                    padding: const EdgeInsets.all(15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(msg,style: TextStyle(fontSize: 15.0,color: Colors.red),),
                  ),
                  new Expanded(
                    child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: selected.length,
                        padding: const EdgeInsets.all(10.0),
                        itemBuilder: (BuildContext context, int index) {
                          return new Column(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new ListTile(
                                  trailing: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selected.removeAt(index);
                                        });
                                      },
                                      child: Icon(Icons.clear, size: 35.0,)
                                  ),
                                  title: Text(selected[index].descripcion),
                                ),
                              ),
                              Divider(
                                height: 2.0,
                                color: Colors.grey,
                              )
                            ],
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
            margin: new EdgeInsets.only(bottom: 10.0),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: (){saveList();}, backgroundColor: Colors.blueAccent, icon: Icon(Icons.save), label: Text('Guardar')
        )
    );
  }

  Future<void> saveList() async{
    if(selected.isEmpty || listNameController.text == ""){
      if(selected.isEmpty) {
        return showDialog(
          context: context,
          barrierDismissible: false, // user must tap button for close dialog!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error!'),
              content: const Text(
                  'No selecciono ningun elemento para guardar'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      else {
        return showDialog(
          context: context,
          barrierDismissible: false, // user must tap button for close dialog!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error!'),
              content: const Text(
                  'Debe ingresar un nombre al listado'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Ok'),
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
    else{
    _insertNewList();
    await new Future.delayed(const Duration(seconds: 2));
      /*Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return InsertList(
            name: listNameController.text,
            selected: selected,
          );
        }),);*/
    }
  }

  void _insertNewList() async{
    _listStateBloc.emitEvent(ListSave(
      event: ListadoEventType.savingList,
      selected: selected,
      name: listNameController.text,
      user: this.user
    ));
  }

  Widget _buildSuccess() {
    return AlertDialog(
      title: Text('Muy bien!'),
      content: Text(
          'Se creo ' + listNameController.text),
      actions: <Widget>[
        FlatButton(
          child: const Text('Ok'),
          onPressed: () {/*
                  Navigator.pop(context,
                    MaterialPageRoute(builder: (context) {
                      return HomePage(
                        clientRepository: _loginBloc.clientRepository,
                      );
                    }),);*/
            Navigator.of(context).pop();
            selected.clear();
          },
        ),
      ],
    );
  }

  Widget _buildFailure() {
    return AlertDialog(
      title: Text('Error!'),
      content: const Text(
          'Error en creacion del listado'),
      actions: <Widget>[
        FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}

