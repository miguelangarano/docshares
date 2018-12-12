import 'package:flutter/material.dart';
import 'Login.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  String _nombre;
  String _materia;
  bool _whereiam = true;
  bool loggedin=false;


  void Docs() {
    print('docs');
    setState(() {
      _whereiam = false;
    });
  }

  void Subir() {
    print('subir');
    setState(() {
      _whereiam = true;
    });
  }

  void goToLogin(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new Login()),
    );
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
        home: new Scaffold(
            backgroundColor: Colors.indigo[50],
            appBar: new AppBar(
                backgroundColor: Colors.indigo[50],
                elevation: 0,
                title: new Row(
                  children: <Widget>[
                    new Image.asset('assets/logo.png', fit: BoxFit.cover),
                    new Center(
                      child: new Text(
                        'Documentos Compartidos',
                        style: TextStyle(
                            fontSize: 18, color: Colors.blueGrey[300]),
                      ),
                    )
                  ],
                )),
            body: new SingleChildScrollView(
              child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  color: Colors.indigo[50],
                  child: new Column(children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: MenuButtons(),
                    ),
                    MainPanel()
                  ])),
            )));
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

  List<Widget> MenuButtons() {
    if (_whereiam == true) {
      return [
        new RaisedButton(
          onPressed: () => Subir(),
          color: new Color.fromRGBO(222, 39, 39, 30.0),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          child: const Text(
            'Sube un documento',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 20,
        ),
        new RaisedButton(
            onPressed: () => Docs(),
            color: new Color.fromRGBO(143, 2, 2, 30.0),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: const Text(
              ' Tus documentos ',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 20)
      ];
    } else {
      return [
        new RaisedButton(
          onPressed: () => Subir(),
          color: new Color.fromRGBO(143, 2, 2, 30.0),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          child: const Text(
            'Sube un documento',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 20,
        ),
        new RaisedButton(
            onPressed: () => Docs(),
            color: new Color.fromRGBO(222, 39, 39, 30.0),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: const Text(
              ' Tus documentos ',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 20)
      ];
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
