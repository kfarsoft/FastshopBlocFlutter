import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/design/colors.dart';

import 'package:fastshop/models/cartItem.dart';
import 'package:fastshop/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

class BlocCartPage extends StatelessWidget {
  BlocCartPage();

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<CartBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Mi Carrito"),
        ),
        body: StreamBuilder<List<CartItem>>(
            stream: cart.items,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data.isEmpty) {
                return Center(
                    child: Text('Vacio',
                        style: Theme.of(context).textTheme.display1));
              }
              return Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: ListView(
                            children: snapshot.data
                                .map((item) => ItemTile(item: item))
                                .toList()),
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: StreamBuilder<double>(
                              stream: cart.itemsTotalPrice,
                              initialData: 0,
                              builder: (context, snapshot) => Text(
                                "Total: \$${num.parse(snapshot.data.toStringAsFixed(2))}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25),
                              ),
                            ),
                            subtitle: StreamBuilder<int>(
                              stream: cart.itemCount,
                              initialData: 0,
                              builder: (context, snapshot) => Text(
                                "Cantidad de productos: ${snapshot.data}",
                                // style: TextStyle(
                                //     fontWeight: FontWeight.w900,
                                //     fontSize: 25),
                              ),
                            ),
                          ),
                          ListTile(
                            title: RaisedButton(
                              color: fButtonColor,
                              onPressed: () => print("nothing"),
                              child: Text("Finalizar Compra",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}