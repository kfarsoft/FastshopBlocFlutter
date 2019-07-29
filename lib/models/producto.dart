import 'dart:convert';
import 'dart:ui';

List<Producto> productoFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Producto>.from(jsonData.map((x) => Producto.fromJson(x)));
}

String productoToJson(List<Producto> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Producto extends Object {
  final int idProducto;
  final String descripcion;
  final double precio;
  final Color color;


  Producto({
    this.idProducto,
    this.descripcion,
    this.precio,
    this.color,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => new Producto(
    idProducto: json["idProducto"],
    descripcion: json["descripcion"],
    precio: json["precio"],

  );

  Map<String, dynamic> toJson() => {
    "idProducto": idProducto,
    "descripcion": descripcion,
    "precio": precio,
  };

  @override
  bool operator==(Object other) => identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => idProducto;
}