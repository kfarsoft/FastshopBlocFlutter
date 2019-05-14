import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
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
    return RaisedButton(
      child: Text('Add...'),
      onPressed: (){
        _shoppingBloc.addToShoppingBasket(widget.shoppingItem);
      },
    );
  }

  Widget _buildRemoveFromShoppingBasket(){
    return RaisedButton(
      child: Text('Remove...'),
      onPressed: (){
        _shoppingBloc.removeFromShoppingBasket(widget.shoppingItem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTileBar(
        leading: Center(
          child: Text(widget.shoppingItem.title),
        ),
        title: Center(
          child: Text('${widget.shoppingItem.price} \$'),
        ),
        trailing: Container(
          child: Center(
            child: _buildButton(),
          ),
        ),
      ),
    );
  }
}
