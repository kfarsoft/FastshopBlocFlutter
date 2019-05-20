// import 'package:flutter/material.dart';
// import 'package:fastshop/widgets/cart_item_widget.dart';
// import 'package:fastshop/models/cart.dart';

// class CartPage extends StatelessWidget {
//   CartPage(this.cart);
//   final Cart cart;

//   static const routeName = "/cart";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Your Cart"),
//       ),
//       body: cart.items.isEmpty
//           ? Center(
//               child: Text('Vacio', style: Theme.of(context).textTheme.display1))
//           : ListView(
//               children:
//                   cart.items.map((item) => ItemTile(item: item)).toList()),
//     );
//   }
// }