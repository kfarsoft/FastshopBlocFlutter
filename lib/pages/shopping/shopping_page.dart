import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/models/producto.dart';
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

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);
    return new Scaffold(
      body: StreamBuilder<List<Producto>>(
        stream: bloc.items,
        builder: (BuildContext context,
            AsyncSnapshot<List<Producto>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
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
      floatingActionButton: FloatingActionButton.extended(onPressed: scan, label: Text('Escanear'), icon: Icon(Icons.camera_alt)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
  }
