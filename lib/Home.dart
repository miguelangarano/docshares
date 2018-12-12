import 'package:flutter/material.dart';
import 'Login.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  String _nombre;
  String _materia;
  int _whereiam = 0;
  bool loggedin=false;

  void goToLogin(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new Login()),
    );
  }

  void home(){
    print('home');
    setState(() {
      _whereiam=0;
    });
  }

  void documentos(){
    print('documentos');
    setState(() {
      _whereiam=1;
    });
  }

  void biblioteca(){
    print('biblioteca');
    setState(() {
      _whereiam=2;
    });
  }

  void logOut(){
    print('Log Out');
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
        home: new Scaffold(
            backgroundColor: Colors.indigo[50],
            appBar: new AppBar(
                backgroundColor: new Color.fromRGBO(222, 39, 39, 1.0),
                elevation: 0,
                title: new Center(
                  child: new Text('Documentos Compartidos', style: TextStyle(fontSize: 18, color: Colors.white)),
                )
            ),
            drawer: new Drawer(
              child: ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(image: AssetImage('assets/logo.png'))
                      ),
                  ),
                  new ListTile(
                    title: new Text('Página Principal'),
                    trailing: new Icon(Icons.home),
                    onTap: home,
                  ),
                  new ListTile(
                    title: new Text('Mis Documentos'),
                    trailing: new Icon(Icons.description),
                    onTap: documentos,
                  ),
                  new ListTile(
                    title: new Text('Biblioteca General'),
                    trailing: new Icon(Icons.import_contacts),
                    onTap: biblioteca,
                  ),
                  new Divider(),
                  new ListTile(
                    title: new Text('Cerrar Sesión'),
                    trailing: new Icon(Icons.power_settings_new),
                    onTap: logOut,
                  )
                ],
              ),
            ),
            body: new SingleChildScrollView(
              child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  color: Colors.indigo[50],
                  child: new Column(children: <Widget>[
                    MainPanel()
                  ]
                  )
              ),
            )
        )
    );
  }

  Widget MainPanel() {
    if (_whereiam == true) {
      return new Container(
          margin: new EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: new Form(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Container(
                  child: new Column(
                    children: SubirButton(),
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.symmetric(vertical: 20),
                  child: new Column(
                    children: buildInputs(),
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.symmetric(vertical: 10),
                  child: ListoButton(),
                )
              ],
            ),
          ));
    } else {
      return new Container(
        margin: new EdgeInsets.symmetric(horizontal: 5, vertical: 30),
        color: Colors.blue,
        child: ListBuilder(),
      );
    }
  }

  List<Widget> buildInputs() {
    return [
      new Container(
          margin: new EdgeInsets.symmetric(vertical: 20),
          child: new TextFormField(
            decoration: new InputDecoration(
                focusedBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: new Color.fromRGBO(255, 255, 255, 60.0))),
                hintText: 'Nombre de archivo',
                hintStyle: new TextStyle(
                    color: new Color.fromRGBO(255, 255, 255, 60.0)),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                fillColor: new Color.fromRGBO(203, 7, 7, 40.0),
                filled: true,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(50),
                    borderSide: new BorderSide(width: 0, color: Colors.black))),
            validator: (value) =>
                value.isEmpty ? 'Nombre de archivo no puede estar vacio' : null,
            onSaved: (value) => _nombre = value,
            style: new TextStyle(color: Colors.white),
          )),
      new Container(
        margin: new EdgeInsets.symmetric(vertical: 20),
        child: new TextFormField(
          decoration: new InputDecoration(
              focusedBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color: new Color.fromRGBO(255, 255, 255, 60.0))),
              hintText: 'Materia',
              hintStyle:
                  new TextStyle(color: new Color.fromRGBO(255, 255, 255, 60.0)),
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              fillColor: new Color.fromRGBO(203, 7, 7, 40.0),
              filled: true,
              border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(50),
                  borderSide: new BorderSide(width: 0, color: Colors.black))),
          validator: (value) =>
              value.isEmpty ? 'Materia no puede estar vacio' : null,
          onSaved: (value) => _materia = value,
          style: new TextStyle(color: Colors.white),
        ),
      ),
    ];
  }

  List<Widget> SubirButton() {
    return [
      new RaisedButton(
        onPressed: goToLogin,
        color: new Color.fromRGBO(143, 2, 2, 30.0),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: const Text(
          'Sube un documento',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 20,
      )
    ];
  }

  Widget ListoButton() {
    return new RaisedButton(
      onPressed: () => print('Hola listo'),
      color: new Color.fromRGBO(143, 2, 2, 30.0),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0)),
      child: const Text(
        '¡Listo!',
        style: TextStyle(color: Colors.white),
      ),
      elevation: 20,
    );
  }

  Widget ListBuilder() {
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          ListItemRed(),
          ListItemRedAccent(),
          ListItemRed(),
          ListItemRedAccent(),
          ListItemRed(),
          ListItemRedAccent(),
          ListItemRed(),
          ListItemRedAccent(),
          ListItemRed(),
          ListItemRedAccent(),
        ],
      ),
    );
  }

  Widget ListItemRed() {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
              width: 200,
              height: 60,
              color: new Color.fromRGBO(222, 39, 39, 30.0),
              child: new Column(
                children: <Widget>[
                  new Text('Nombre: Deber 1', style: new TextStyle(color: Colors.white),),
                  new Text('Materia: Matematicas', style: new TextStyle(color: Colors.white),),
                  new Text('Subido por: Juan Perez', style: new TextStyle(color: Colors.white),)
                ],
              )),
          new Container(
            width: 104,
            height: 60,
            color: new Color.fromRGBO(222, 39, 39, 30.0),
            child: new Center(
              child: new Image.asset('assets/doc.png', fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }

  Widget ListItemRedAccent() {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
              width: 200,
              height: 60,
              color: new Color.fromRGBO(143, 2, 2, 30.0),
              child: new Column(
                children: <Widget>[
                  new Text('Nombre: Deber 1', style: new TextStyle(color: Colors.white),),
                  new Text('Materia: Matematicas', style: new TextStyle(color: Colors.white),),
                  new Text('Subido por: Juan Perez', style: new TextStyle(color: Colors.white),)
                ],
              )),
          new Container(
            width: 104,
            height: 60,
            color: new Color.fromRGBO(143, 2, 2, 30.0),
            child: new Center(
              child: new Image.asset('assets/doc.png', fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
