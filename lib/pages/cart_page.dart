// import 'package:fastshop/bloc_helpers/bloc_provider.dart';
// import 'package:fastshop/blocs/cart/cart_boc.dart';
// import 'package:fastshop/models/product.dart';
// import 'package:fastshop/widgets/cart_item_widget.dart';
// import 'package:flutter/material.dart';

// class CartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     CartBloc bloc = BlocProvider.of<CartBloc>(context);

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Carrito de compras'),
//         ),
//         body: Container(
//           child: StreamBuilder<List<Product>>(
//             stream: bloc.cart,
//             builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
//               if (! snapshot.hasData){
//                 return Container();
//               }

//               return ListView.builder(

//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index){
//                   return CartItemWidget(cartItem: snapshot.data[index]);
//                 },
//               );
//             },
//             ),
//         ),
//       ),
//     );
//   }
// }

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_boc.dart';

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

              return ListView(
                  children: snapshot.data
                      .map((item) => ItemTile(item: item))
                      .toList());
            }));
  }
}