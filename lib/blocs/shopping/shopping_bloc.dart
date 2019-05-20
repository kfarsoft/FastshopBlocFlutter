import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/models/product.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingBloc implements BlocBase {
  // List of all items, part of the shopping basket
  Set<Product> _shoppingBasket = Set<Product>();

  // Stream to list of all possible items
  BehaviorSubject<List<Product>> _itemsController = BehaviorSubject<List<Product>>();
  Stream<List<Product>> get items => _itemsController;

  BehaviorSubject<int> _shoppingBasketSizeController = BehaviorSubject<int>.seeded(0);
  Stream<int> get shoppingBasketSize => _shoppingBasketSizeController;

  BehaviorSubject<double> _shoppingBasketPriceController = BehaviorSubject<double>.seeded(0.0);
  Stream<double> get shoppingBasketTotalPrice => _shoppingBasketPriceController;

  // Stream to list the items part of the shopping basket
  BehaviorSubject<List<Product>> _shoppingBasketController = BehaviorSubject<List<Product>>.seeded(<Product>[]);
  Stream<List<Product>> get shoppingBasket => _shoppingBasketController;

  @override
  void dispose() {
    _itemsController?.close();
    _shoppingBasketSizeController?.close();
    _shoppingBasketController?.close();
    _shoppingBasketPriceController?.close();
  }

  // Constructor
  ShoppingBloc() {
    _loadShoppingItems();
  }

  void addToShoppingBasket(Product item){
    // item.quantity++;
    _shoppingBasket.add(item);
    _postActionOnBasket();
  }

  void removeFromShoppingBasket(Product item){
    _shoppingBasket.remove(item);
    _postActionOnBasket();
  }

  void _postActionOnBasket(){
    _shoppingBasketController.sink.add(_shoppingBasket.toList());
    _shoppingBasketSizeController.sink.add(_shoppingBasket.length);
    _computeShoppingBasketTotalPrice();
  }

  void _computeShoppingBasketTotalPrice(){
    double total = 0.0;
    _shoppingBasket.forEach((Product item){
      total += item.price;
    });
    total = num.parse(total.toStringAsFixed(2)); 
    _shoppingBasketPriceController.sink.add(total);
  }

  //
  // Generates a series of Shopping Items
  // Normally this should come from a call to the server
  // but for this sample, we simply simulate
  //
  void _loadShoppingItems() {
    _itemsController.sink.add(List<Product>.generate(50, (int index) {
      return Product(
        id: index,
        name: "Item $index",
        price: ((Random().nextDouble() * 40.0 + 10.0) * 100.0).roundToDouble() /
            100.0,
        color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0),
      );
    }));
  }
}
