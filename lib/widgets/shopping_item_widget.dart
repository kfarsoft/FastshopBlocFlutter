import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_boc.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/blocs/shopping/shopping_item_bloc.dart';
import 'package:fastshop/models/shopping_item.dart';
import 'package:flutter/material.dart';

class ShoppingItemWidget extends StatefulWidget {
  ShoppingItemWidget({
    Key key,
    @required this.shoppingItem,
  }) : super(key: key);

  final ShoppingItem shoppingItem;

  @override
  _ShoppingItemWidgetState createState() => _ShoppingItemWidgetState();
}

class _ShoppingItemWidgetState extends State<ShoppingItemWidget> {
  StreamSubscription _subscription;
  ShoppingItemBloc _bloc;
  ShoppingBloc _shoppingBloc;
  CartBloc _cartBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // As the context should not be used in the "initState()" method,
    // prefer using the "didChangeDependencies()" when you need
    // to refer to the context at initialization time
    _initBloc();
  }

  @override
  void didUpdateWidget(ShoppingItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // as Flutter might decide to reorganize the Widgets tree
    // it is preferable to recreate the links
    _disposeBloc();
    _initBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  // This routine is reponsible for creating the links
  void _initBloc() {
    // Create an instance of the ShoppingItemBloc
    _bloc = ShoppingItemBloc(widget.shoppingItem);

    // Retrieve the BLoC that handles the Shopping Basket content 
    _shoppingBloc = BlocProvider.of<ShoppingBloc>(context);

    _cartBloc = BlocProvider.of<CartBloc>(context);
    // Simple pipe that transfers the content of the shopping
    // basket to the ShoppingItemBloc
    _subscription = _shoppingBloc.shoppingBasket.listen(_bloc.shoppingBasket);
  }

  void _disposeBloc() {
    _subscription?.cancel();
    _bloc?.dispose();
  }

  Widget _buildButton() {
    return StreamBuilder<bool>(
      stream: _bloc.isInShoppingBasket,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return snapshot.data
            ? _buildRemoveFromShoppingBasket()
            : _buildAddToShoppingBasket();
      },
    );
  }

  Widget _buildAddToShoppingBasket(){
    return IconButton(
      icon: Icon(Icons.add_circle_outline, color: Colors.green,), 
      onPressed: (){
        _cartBloc.addToCart(widget.shoppingItem);
      },
    );
  }

  Widget _buildRemoveFromShoppingBasket(){
    return IconButton(
      icon: Icon(Icons.remove_circle_outline, color: Colors.red,), 
      onPressed: (){
        _shoppingBloc.removeFromShoppingBasket(widget.shoppingItem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
        return Card(
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: <Widget>[
ListTile(
        leading: 
 Text(widget.shoppingItem.title),
        
        title: 
        Container(
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: <Widget>[

             Text('\$${widget.shoppingItem.price}'),          
           ],
          )
          
        ),

        trailing: 
        // Container(
          // child: 
          // Center(
           _buildButton(),
          // ),
        // ),
      ),
          ],),
    );
  }
}
