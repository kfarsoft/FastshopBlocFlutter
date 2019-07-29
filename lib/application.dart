import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/authentication/authentication_bloc.dart';
import 'package:fastshop/blocs/cart/cart_boc.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/pages/authentication/authentication_page.dart';
import 'package:fastshop/pages/shopping/cart_page.dart';
import 'package:fastshop/pages/decision/decision_page.dart';
import 'package:fastshop/pages/authentication/initialization_page.dart';
import 'package:fastshop/pages/registration/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:fastshop/user_repository/user_repository.dart';

class Application extends StatelessWidget {

  final UserRepository userRepository;

  Application({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(userRepository: userRepository),
      child: MaterialApp(
        title: 'FastShop',
        theme: ThemeData(
          primarySwatch: primaryColor,
        ),
        routes:
        {
          '/decision': (BuildContext context) => DecisionPage(userRepository: userRepository,),
          '/register': (BuildContext context) => RegistrationPage(),
          '/loginScreen': (BuildContext context) => AuthenticationPage(),
          '/shoppingBasket': (BuildContext context) => BlocCartPage(),
        },
        home: InitializationPage(),
      ),
    );
  }
}
