import 'package:fastshop/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fastshop/user_repository/user_repository.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(Application(userRepository: UserRepository()));
}
