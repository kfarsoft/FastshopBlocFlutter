import 'package:fastshop/blocs/home/promo_bloc.dart';
import 'package:fastshop/models/models.dart';
import 'package:fastshop/widgets/promo_card_widget.dart';
import 'package:flutter/material.dart';

class PromoVigentes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PromocionesVigentes(),
    );
  }
}

class PromocionesVigentes extends StatefulWidget {
  PromocionesVigentes({Key key}) : super(key: key);

  @override
  PromoVigentesState createState() => PromoVigentesState();
}


class PromoVigentesState extends State<PromocionesVigentes> {

  @override
  void initState() {
    bloc.fetchAllTodo();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        //Estamos escuchando al stream,
        //cuando el valor sale afuera del stream largamos la lista por pantalla
        stream: bloc.allTodo,
        builder: (context, AsyncSnapshot<List<Promocion>> snapshot) {
          if (snapshot.hasData) {
            //Aca largamos la lista a la pantalla
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text('Error es:${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<Promocion>> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
          enableFeedback: true,
          child: new PromoCard(title: snapshot.data[index].promocion + ' en ' + snapshot.data[index].producto,
          date: 'Del ' + snapshot.data[index].fechaInicio + ' al ' + snapshot.data[index].fechaFin
          ),
        );
      },
    );
  }

}
