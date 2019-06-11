import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/models/product.dart';
import 'package:fastshop/widgets/shopping_basket.dart';
import 'package:fastshop/widgets/shopping_item_widget.dart';
import 'package:flutter/material.dart';

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);

    return Scaffold(
      appBar: AppBar(
    title: Text('Shopping Page'),
    actions: <Widget>[
      ShoppingBasket(),
    ],
      ),
      body: Container(
    child: StreamBuilder<List<Product>>(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<List<Product>> snapshot) {
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
      ),
    );
  }
}
