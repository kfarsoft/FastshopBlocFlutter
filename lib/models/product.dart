import 'dart:ui';

class Product extends Object {
  final int id;
  final String name;
  final double price;
  final Color color;


  Product({
    this.id,
    this.name,
    this.price,
    this.color,
  });

  @override
  bool operator==(Object other) => identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;
}