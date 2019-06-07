
class Cliente {

  final String username;
  final String token;
  final String idCliente;

  Cliente(this.username, this.token, this.idCliente);

  /*Cliente.empty(){
    this.username = "";
    this.token = "";
    this.idCliente = "";
  }*/

  String getId(){
    return idCliente;
  }

  Cliente.fromJson(Map<String, dynamic> json)
    : username = json["username"],
      idCliente = json["idCliente"],
      token = json["token"];

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'idCliente': idCliente,
        'token': token,
      };
}
