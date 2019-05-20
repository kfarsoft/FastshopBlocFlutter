import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_boc.dart';
import 'package:fastshop/models/cartItem.dart';
import 'package:fastshop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

Widget _buildRemoveFromShoppingBasket() {
  return IconButton(
    icon: Icon(
      Icons.remove_circle_outline,
      color: Colors.red,
    ),
    onPressed: () {
      // _cartBloc.removeFromShoppingBasket(widget.cartItem);
      print('remove');
    },
  );
}

class ItemTile extends StatelessWidget {
  ItemTile({this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        child: ListTile(
          isThreeLine: true,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item.product.name),
                Text('\$${item.product.price * item.count}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _showDialog(context);
                },
                child: Text('\nCantidad ${item.count}',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline)),
              ),
              Text('\nPrec/U. \$${item.product.price}'),
            ],
          ),
          trailing: Container(
            child: _buildRemoveFromShoppingBasket(),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            initialIntegerValue: item.count,
            minValue: 1,
            maxValue: 100,
            title: Text('Elige una cantidad'),
            // step: 10,
            // onChanged: (value) => setState(() => widget.cartItem.quantity = value),
            //aca hay que decirle al bloc que la cantidad cambio!
          );
        }).then((int value) {
      if (value != null) {
        cartBloc.cartUpdate.add(CartAddition(item.product, value));
      }
    });
  }
}