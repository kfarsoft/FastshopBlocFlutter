class Connection{

  var url = '';

  String getUrl() {
    //url = "192.168.1.13";                   //Para el android emulator
    url = "10.1.1.70";                  //Para celular
    //url = "localhost";                  //Para celular
    //url = "app-1538168783.000webhostapp.com";   //Para celular
    return url;
  }
}
Connection con = Connection();