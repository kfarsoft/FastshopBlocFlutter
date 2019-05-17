import 'dart:async';

import 'package:fastshop/pages/shopping_page.dart';
import 'package:fastshop/widgets/log_out_button.dart';
import 'package:fastshop/widgets/shopping_basket.dart';
import 'package:fastshop/widgets/shopping_basket_price.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('FastShop'),
            leading: Container(),
            actions: <Widget>[
              LogOutButton(),
            ],
          ),
          body: Container(
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
        ),
      ),
    );
  }
}
