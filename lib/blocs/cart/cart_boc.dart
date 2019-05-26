import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/models/cart.dart';
import 'package:fastshop/models/cartItem.dart';
import 'package:fastshop/models/product.dart';
import 'package:rxdart/subjects.dart';

class CartAddition {
  final Product product;
  final int count;

  CartAddition(this.product, [this.count = 1]);
}


class CartBloc implements BlocBase {
  //list of all items part of the cart
  // Set<Product> _cart = Set<Product>();
  final Cart _cart = Cart();

  final BehaviorSubject<List<CartItem>> _items =
      BehaviorSubject<List<CartItem>>.seeded([]);

  final BehaviorSubject<int> _itemCount = BehaviorSubject<int>.seeded(0);

  final StreamController<double> _itemTotalPrice = BehaviorSubject<double>.seeded(0);

  final StreamController<CartAddition> _cartAdditionController =
      StreamController<CartAddition>();

  final StreamController<CartAddition> _cartUpdateController =
      StreamController<CartAddition>();


  CartBloc(){
    _cartAdditionController.stream.listen((addition) {
      int currentCount = _cart.itemCount;
      double currentTotalPrice = _cart.itemTotalPrice;
      _cart.add(addition.product, addition.count);
      _items.add(_cart.items);
      int updatedCount = _cart.itemCount;
      double updatedTotalPrice = _cart.itemTotalPrice;
      if (updatedCount != currentCount || updatedTotalPrice != currentTotalPrice) {
        _itemCount.add(updatedCount);
        _itemTotalPrice.add(updatedTotalPrice);
      }
    });
    _cartUpdateController.stream.listen((addition){
      int currentCount = _cart.itemCount;
      double currentTotalPrice = _cart.itemTotalPrice;
      _cart.update(addition.product, addition.count);
      _items.add(_cart.items);
      int updatedCount = _cart.itemCount;
      double updatedTotalPrice = _cart.itemTotalPrice;
      if (updatedCount != currentCount || updatedTotalPrice != currentTotalPrice) {
        _itemCount.add(updatedCount);
        _itemTotalPrice.add(updatedTotalPrice);
      }
    });
  }



  Sink<CartAddition> get cartAddition => _cartAdditionController.sink;

  Sink<CartAddition> get cartUpdate => _cartUpdateController.sink;

  Stream<int> get itemCount => _itemCount.stream;

  Stream<double> get itemsTotalPrice => _itemTotalPrice.stream;

  Stream<List<CartItem>> get items => _items.stream;

  @override
  void dispose() {
    _items.close();
    _itemCount.close();
    _itemTotalPrice.close();
    _cartAdditionController.close();
    _cartUpdateController.close();
  }
}