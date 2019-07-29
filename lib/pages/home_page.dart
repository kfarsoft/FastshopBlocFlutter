import 'dart:async';
import 'package:fastshop/functions/getUsername.dart';
import 'package:fastshop/pages/active_offer.dart';
import 'package:fastshop/pages/category_page.dart';
import 'package:fastshop/pages/listados/shop_list_page.dart';
import 'package:fastshop/pages/shopping/shopping_page.dart';
import 'package:fastshop/widgets/log_out_button.dart';
import 'package:fastshop/widgets/shopping_basket.dart';
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
            ShoppingBasket(),
            LogOutButton(),
          ],
          bottom: new TabBar(
              isScrollable: true,
              controller: controller,
              tabs: <Tab>[
                Tab(text: "Promociones vigentes",icon: new Icon(Icons.pages)),
                Tab(text: "Listado de Compras",icon: new Icon(Icons.list)),
                Tab(text: "Categorias",icon: new Icon(Icons.shop)),
                Tab(text: "Carrito",icon: new Icon(Icons.shopping_cart)),
              ]
          ),
        ),
        body: TabBarView(
            controller: controller,
            children: <Widget>[
              ActiveOfferPage(),
              ShopListPage(),
              CategoryPage(),
              ShoppingPage()
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
