import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/models/producto.dart';
import 'package:fastshop/repos/producto_repository.dart';
import 'package:fastshop/widgets/shopping_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ShoppingPage extends StatefulWidget {

  @override
  _ShoppingPageState createState() => new _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  String barcode = "";
final _repo = ProductoRepository();

  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    CartBloc _cartBloc = BlocProvider.of<CartBloc>(context);
    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);
    return new Scaffold(
      body: StreamBuilder<List<Producto>>(
        stream: bloc.items,
        builder: (BuildContext context,
            AsyncSnapshot<List<Producto>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: Text('Vacio', style: Theme.of(context).textTheme.display1),
              ),
            );
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
      floatingActionButton: FloatingActionButton.extended(onPressed: (){scan(_cartBloc, _repo);}, label: Text('Escanear'), icon: Icon(Icons.camera_alt)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future scan(CartBloc _cartBloc, ProductoRepository _repo) async {
    try {
      String barcode = await BarcodeScanner.scan();
      //lo deberia hacer a nivel local
      Producto producto = await _repo.fetchProductScanned(barcode);
      _cartBloc.cartAddition.add(CartAddition(producto));
      // setState(() {
      //   this.barcode = barcode;
      //   bloc.addScanProduct(barcode);
      // });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Necesitamos acceso a la camara para continuar.';
        });
      } else {
        setState(() => this.barcode = 'Error desconocido: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Error desconocido: $e');
    }
  }
  }
