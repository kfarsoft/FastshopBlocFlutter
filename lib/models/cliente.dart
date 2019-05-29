
class Cliente {

  String username;
  String idCliente;
  String email;
  String password;
  String name;
  String token;

  Cliente();

  Cliente.empty(){
    this.email = "";
    this.password = "";
    this.name = "";
    this.idCliente = "";
  }

  String getId(){
    return idCliente;
  }

  Cliente.fromJson(Map<String, dynamic> json)
    : username = json["username"],
      name = json["nombre"],
      idCliente = json["idCliente"],
      token = json["jwt"];
}
