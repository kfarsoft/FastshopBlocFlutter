import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/models/shopping_item.dart';
// import 'package:rxdart/rxdart.dart';

class CartItemBloc implements BlocBase {


  @override
  void dispose() {
    /// TODO:implement dispose
  }
   CartItemBloc(ShoppingItem shoppingItem);
}