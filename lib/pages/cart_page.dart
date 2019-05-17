import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_boc.dart';
import 'package:fastshop/models/shopping_item.dart';
import 'package:fastshop/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartBloc bloc = BlocProvider.of<CartBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carrito de compras'),
        ),
        body: Container(
          child: StreamBuilder<List<ShoppingItem>>(
            stream: bloc.cart,
            builder: (BuildContext context, AsyncSnapshot<List<ShoppingItem>> snapshot){
              if (! snapshot.hasData){
                return Container();
              }

              return ListView.builder(

                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return CartItemWidget(cartItem: snapshot.data[index]);
                },
              );
            },
            ),
        ),
      ),
    );
  }
}