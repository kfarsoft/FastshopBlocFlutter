import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/models/producto.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingItemBloc implements BlocBase {
  // Stream to notify if the ShoppingItemWidget is part of the shopping basket
  BehaviorSubject<bool> _isInShoppingBasketController = BehaviorSubject<bool>();
  Stream<bool> get isInShoppingBasket => _isInShoppingBasketController;

  // Stream that receives the list of all items, part of the shopping basket
  PublishSubject<List<Producto>> _shoppingBasketController = PublishSubject<List<Producto>>();
  Function(List<Producto>) get shoppingBasket => _shoppingBasketController.sink.add;

  // Constructor with the 'identity' of the shoppingItem
  ShoppingItemBloc(Producto shoppingItem){
    // Each time a variation of the content of the shopping basket
    _shoppingBasketController.stream
    // we check if this shoppingItem is part of the shopping basket
        .map((list) => list.any((Producto item) => item.idProducto == shoppingItem.idProducto))
    // if it is part
        .listen((isInShoppingBasket)
    // we notify the ShoppingItemWidget
    => _isInShoppingBasketController.add(isInShoppingBasket));
  }

  @override
  void dispose() {
    _isInShoppingBasketController?.close();
    _shoppingBasketController?.close();
  }
}