import 'package:fastshop/application.dart';
import 'package:fastshop/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:user_repository/user_repository.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(Application(userRepository: UserRepository()));
}
