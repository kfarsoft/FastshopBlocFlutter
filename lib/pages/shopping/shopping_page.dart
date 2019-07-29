import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/models/producto.dart';
import 'package:fastshop/widgets/shopping_item_widget.dart';
import 'package:flutter/material.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);
    return new Scaffold(
      body: StreamBuilder<List<Producto>>(
        stream: bloc.items,
        builder: (BuildContext context,
            AsyncSnapshot<List<Producto>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ShoppingItemWidget(
                shoppingItem: snapshot.data[index],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: null, label: Text('Escanear'), icon: Icon(Icons.camera_alt)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  }
