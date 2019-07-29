import 'package:fastshop/bloc_helpers/bloc_provider.dart';
// import 'package:fastshop/blocs/cart/cart_boc.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/models/producto.dart';
import 'package:fastshop/widgets/shopping_item_widget.dart';
import 'package:flutter/material.dart';

class ShoppingBasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShoppingBloc shoppingBloc = BlocProvider.of<ShoppingBloc>(context);
    // CartBloc  cartBloc = BlocProvider.of<CartBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Carrito'),
      ),
      body: Container(
        child: StreamBuilder<List<Producto>>(
          stream: shoppingBloc.shoppingBasket,
          builder: (BuildContext context,
              AsyncSnapshot<List<Producto>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ShoppingItemWidget(shoppingItem: snapshot.data[index]);
              },
            );
          },
        ),
      ),
    );
  }
}