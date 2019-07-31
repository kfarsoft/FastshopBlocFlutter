class Connection{

  var url = '';

  String getUrl() {
    //url = "192.168.1.13";                   //Para el android emulator
    url = "192.168.1.139";  //para mi cel
    // url = "127.0.0.1/FASTSHOP";  //para mi cel

    //  url = "10.1.1.0/FASTSHOP";                  //Para celular
    //  url = "10.1.1.107";                  //Para celular
    //url = "localhost";                  //Para celular
    // url = "app-1538168783.000webhostapp.com";   //Para celular
    return url;
  }
}
Connection con = Connection();