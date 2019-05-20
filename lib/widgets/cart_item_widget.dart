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
            minValue: 0,
            maxValue: 100,
            title: Text('Elige una cantidad'),
            // step: 10,
            // onChanged: (value) => setState(() => widget.cartItem.quantity = value),
            //aca hay que decirle al bloc que la cantidad cambio!
          );
        }).then((int value) {
      if (value != null) {
        print("cambiar cantidad");
        cartBloc.cartUpdate.add(CartAddition(item.product, value));
      }
    });
  }
}

// import 'package:fastshop/bloc_helpers/bloc_provider.dart';
// import 'package:fastshop/blocs/cart/cart_boc.dart';
// // import 'package:fastshop/blocs/cart/cart_item_bloc.dart';
// import 'package:fastshop/models/product.dart';
// import 'package:flutter/material.dart';
// import 'package:numberpicker/numberpicker.dart';

// class CartItemWidget extends StatefulWidget {
//   CartItemWidget({
//     Key key,
//     @required this.cartItem,
//   }) : super(key: key);

//   final Product cartItem;

//   @override
//   _CartItemWidgetState createState() => _CartItemWidgetState();
// }

// class _CartItemWidgetState extends State<CartItemWidget> {
//   StreamSubscription _subscription;
//   // CartItemBloc _bloc;
//   CartBloc _cartBloc;
//   NumberPicker integerNumberPicker;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // As the context should not be used in the "initState()" method,
//     // prefer using the "didChangeDependencies()" when you need
//     // to refer to the context at initialization time
//     _initBloc();
//   }

//   @override
//   void didUpdateWidget(CartItemWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     // as Flutter might decide to reorganize the Widgets tree
//     // it is preferable to recreate the links
//     _disposeBloc();
//     _initBloc();
//   }

//   @override
//   void dispose() {
//     _disposeBloc();
//     super.dispose();
//   }

//   // This routine is reponsible for creating the links
//   void _initBloc() {
//     // Create an instance of the CartItemBloc
//     // _bloc = CartItemBloc(widget.cartItem);

//     // Retrieve the BLoC that handles the Cart content
//     _cartBloc = BlocProvider.of<CartBloc>(context);

//     // Simple pipe that transfers the content of the cart
//     // to the CartItemBloc
//     // _subscription = _cartBloc.cart.listen();
//   }

//   void _disposeBloc() {
//     // _subscription?.cancel();
//     _cartBloc?.dispose();
//   }

//   // Widget _buildButton() {
//   //   return StreamBuilder<bool>(
//   //     stream: _bloc.isInShoppingBasket,
//   //     initialData: false,
//   //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//   //       return snapshot.data
//   //           ? _buildRemoveFromShoppingBasket()
//   //           : _buildAddToShoppingBasket();
//   //     },
//   //   );
//   // }

//   // Widget _buildAddToShoppingBasket(){
//   //   return IconButton(
//   //     icon: Icon(Icons.add_circle_outline, color: Colors.green,),
//   //     onPressed: (){
//   //       _cartBloc.addToShoppingBasket(widget.cartItem);
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 1,
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             isThreeLine: true,
//             title: Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(widget.cartItem.name),
//                   Text('\$${widget.cartItem.price * widget.cartItem.}',
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//             subtitle: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 GestureDetector(
//                   onTap: () {
//                     _showDialog();
//                   },
//                   child: Text('\nCantidad ${widget.cartItem.quantity}',
//                       style: TextStyle(
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline)),
//                 ),
//                 Text('\nPrec/U. \$${widget.cartItem.price}'),
//               ],
//             ),

//             trailing:

//                 // Container(
//                 // child:
//                 // Center(
//                 _buildRemoveFromShoppingBasket(),
//             // ),
//             // ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showDialog() {
//     showDialog<int>(
//         context: context,
//         builder: (BuildContext context) {
//           return new NumberPickerDialog.integer(
//             initialIntegerValue: widget.cartItem.quantity,
//             minValue: 0,
//             maxValue: 100,
//             title: Text('Elige una cantidad'),
//             // step: 10,
//             // onChanged: (value) => setState(() => widget.cartItem.quantity = value),
//             //aca hay que decirle al bloc que la cantidad cambio!
//           );
//         }).then((int value) {
//       if (value != null) {
//         _cartBloc.updateQuantity(widget.cartItem, value);
//       }
//     });
//   }
// }
