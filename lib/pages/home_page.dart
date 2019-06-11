import 'dart:async';
import 'package:fastshop/functions/getUsername.dart';
import 'package:fastshop/pages/listados/listado_compras.dart' as LisCom;
import 'package:fastshop/pages/promociones_vigentes.dart' as ProVig;
import 'package:fastshop/pages/categorias_page.dart' as ProFav;
import 'package:fastshop/pages/mis_gastos.dart' as MisGas;
import 'package:fastshop/widgets/log_out_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {

  @override
  HomePageSample createState() => new HomePageSample();
}

class HomePageSample extends State<HomePage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  TabController controller;

  var user;
  Future<void> _getUsername() async {
    user = await getUsername();
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 4);
    _saveCurrentRoute("/HomeScreen");
    _getUsername();
  }

  _saveCurrentRoute(String lastRoute) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('LastScreenRoute', lastRoute);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido $user'),
          leading: Container(),
          actions: <Widget>[
            LogOutButton(),
          ],
          bottom: new TabBar(
              isScrollable: true,
              controller: controller,
              tabs: <Tab>[
                new Tab(text: "Promociones vigentes",icon: new Icon(Icons.pages)),
                new Tab(text: "Listado de Compras",icon: new Icon(Icons.list)),
                new Tab(text: "Productos",icon: new Icon(Icons.shop)),
                new Tab(text: "Mis gastos",icon: new Icon(Icons.account_balance)),
              ]
          ),
        ),
        body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new ProVig.PromoVigentes(),
              new LisCom.LisCompra(),
              new ProFav.CategoryPage(),
              new MisGas.MisGastos()
            ]
        )
      ),
    );
  }
}



/*
Container(
          child: Column(
            children: <Widget>[

              ListTile(
                title: RaisedButton(
                  child: Text('Shopping'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ShoppingPage(),
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                title: RaisedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Mi Carrito'),
                      SizedBox(
                        width: 16.0,
                      ),
                      ShoppingBasket(),
                      SizedBox(
                        width: 16.0,
                      ),
                      ShoppingBasketPrice(),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/shoppingBasket');
                  },
                ),
              ),
            ],
          ),
        ),
 */
