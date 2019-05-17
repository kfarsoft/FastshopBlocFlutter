import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/models/shopping_item.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc implements BlocBase{
  //list of all items part of the cart
  Set<ShoppingItem> _cart = Set<ShoppingItem>();

  //size of the cart
  BehaviorSubject<int> _cartSizeController = BehaviorSubject<int>.seeded(0);
  Stream<int> get cartSize => _cartSizeController;

  //total price of the cart
  BehaviorSubject<double> _cartPriceController = BehaviorSubject<double>.seeded(0.0);
  Stream<double> get cartTotalPrice => _cartPriceController;

  //items in the cart
  BehaviorSubject<List<ShoppingItem>> _cartController = BehaviorSubject<List<ShoppingItem>>.seeded(<ShoppingItem>[]);
  Stream<List<ShoppingItem>> get cart => _cartController;


  @override
  void dispose() {
    _cartSizeController?.close();
    _cartPriceController.close();
    _cartController.close();
  }

  CartBloc();

  void addToCart(ShoppingItem item){
    if(item.quantity== 0) item.quantity++;
    _cart.contains(item)
    //not so sure deberia llamar al item para que lo actualice ahi. 
    //para que no relodee todo el listado deberia solo actualizar 
    //el item que le incumbre (deberia llamar al cart_item_bloc)
    ? _cart.forEach((ShoppingItem f)  {
      if(f.id == item.id){
        f.quantity++;
      }
    })
    : _cart.add(item);
    _postActionOnCart();
    }

  void _postActionOnCart() {
      _cartController.sink.add(_cart.toList());
      _computeTotalSizeAndPrice();
    }
      
    void _computeTotalSizeAndPrice() {
      double total = 0.0;
      int quantity = 0;
      _cart.forEach((ShoppingItem item){
        total += item.price * item.quantity;
        quantity += item.quantity;
      });
      _cartPriceController.sink.add(total);
      _cartSizeController.sink.add(quantity);
    }
  
}