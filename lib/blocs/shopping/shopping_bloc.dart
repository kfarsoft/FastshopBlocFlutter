import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/models/producto.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingBloc implements BlocBase {

  BehaviorSubject<List<Producto>> _itemsController = BehaviorSubject<List<Producto>>();
  Stream<List<Producto>> get items => _itemsController;

  // Stream to list the items part of the shopping basket
  BehaviorSubject<List<Producto>> _shoppingBasketController = BehaviorSubject<List<Producto>>.seeded(<Producto>[]);
  Stream<List<Producto>> get shoppingBasket => _shoppingBasketController;

  @override
  void dispose() {
    _itemsController?.close();
  }

  // Constructor
  ShoppingBloc() {
    _loadShoppingItems();
  }


  void _loadShoppingItems() {
    _itemsController.sink.add(List<Producto>.generate(50, (int index) {
      return Producto(
        idProducto: index,
        descripcion: "Item $index",
        precio: ((Random().nextDouble() * 40.0 + 10.0) * 100.0).roundToDouble() /
            100.0,
        color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0),
      );
    }));
  }

}