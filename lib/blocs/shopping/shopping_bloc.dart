import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/models/producto.dart';
import 'package:fastshop/repos/producto_repository.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingBloc implements BlocBase {
  // List of all items, part of the shopping basket
  Set<Producto> _shoppingBasket = Set<Producto>();
  final _repo = ProductoRepository();
  // Stream to list of all possible items


  BehaviorSubject<List<Producto>> _itemsController = BehaviorSubject<List<Producto>>();
  Stream<List<Producto>> get items => _itemsController;


  BehaviorSubject<int> _shoppingBasketSizeController = BehaviorSubject<int>.seeded(0);
  Stream<int> get shoppingBasketSize => _shoppingBasketSizeController;

  BehaviorSubject<double> _shoppingBasketPriceController = BehaviorSubject<double>.seeded(0.0);
  Stream<double> get shoppingBasketTotalPrice => _shoppingBasketPriceController;

  // Stream to list the items part of the shopping basket
  BehaviorSubject<List<Producto>> _shoppingBasketController = BehaviorSubject<List<Producto>>.seeded(<Producto>[]);
  Stream<List<Producto>> get shoppingBasket => _shoppingBasketController;

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

  void addToShoppingBasket(Producto item){
    // item.quantity++;
    _shoppingBasket.add(item);
    _postActionOnBasket();
  }

  void removeFromShoppingBasket(Producto item){
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
    _shoppingBasket.forEach((Producto item){
      total += item.precio;
    });
    total = num.parse(total.toStringAsFixed(2));
    _shoppingBasketPriceController.sink.add(total);
  }


  void _loadShoppingItems() async{
    List<Producto> producto = await _repo.fetchProductList();
    await Future.delayed(Duration(seconds: 2));
    //NO ESTA CARGANDO EN EL STREAM
    _itemsController.sink.add(producto);
  }
}