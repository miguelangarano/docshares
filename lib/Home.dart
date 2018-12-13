import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'Auth.dart';
import 'dart:io';

class Home extends StatefulWidget {
  Home({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  String _nombre;
  String _materia;
  int _whereiam = 0;
  bool loggedin=false;
  String _filePath;

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

  void logOut() async{
    print('Log Out');
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }catch(error){
      print(error);
    }
  }

  void selectFile() async{
    print('select file');
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);

      if (filePath == '') {
        File file=File(filePath);
        final StorageReference storageReference=FirebaseStorage.instance.ref().child('algo.jpg');
        final StorageUploadTask uploadTask=storageReference.putFile(file);
      }
      print("File path: " + filePath);
      setState((){this._filePath = filePath;});
    }catch (e) {
      print("Error while picking the file: " + e.toString());
    }
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
            drawer: NavigationDrawer(),
            body: MainPanel()
        )
    );
  }

  Widget NavigationDrawer(){
    return new Drawer(
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
    );
  }

  Widget MainPanel() {
    if (_whereiam == 0) {
      return Principal();
    } else if(_whereiam == 1) {
      return Documentos();
    }else if (_whereiam == 2){
      return Biblioteca();
    }
  }

  Widget Principal(){
    return new SingleChildScrollView(
      child: new Container(
          margin: new EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: new Form(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Container(
                  child: Principal_SubirButton(),
                ),
                new Container(
                  margin: new EdgeInsets.symmetric(vertical: 20),
                  child: new Column(
                    children: Principal_Inputs(),
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.symmetric(vertical: 10),
                  child: Principal_ListoButton(),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget Documentos(){
    return new Container(
      //margin: new EdgeInsets.symmetric(horizontal: 5, vertical: 30),
      //width: 100,
      child: Documentos_ListBuilder(),
    );
  }

  Widget Biblioteca(){
    return new Container(
      margin: new EdgeInsets.only(left: 20, top: 60, right: 10, bottom: 0),
      child: new GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index){
            return Biblioteca_Card(index);
          }
      ),
    );
  }

  List<Widget> Principal_Inputs() {
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

  Widget Principal_SubirButton() {
    return new RaisedButton(
        onPressed: selectFile,
        color: new Color.fromRGBO(143, 2, 2, 30.0),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: const Text(
          'Sube un documento',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 20,
      );
  }

  Widget Principal_ListoButton() {
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

  Widget Documentos_ListBuilder() {
    return new ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        if(index%2==0){
          return Documentos_ListItemRedAccent();
        }else{
          return Documentos_ListItemRed();
        }
      },
    );
  }

  Widget Documentos_ListItemRed() {
    return new Container(
      child: new Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
              padding: new EdgeInsets.symmetric(vertical: 10),
              width: 235,
              height: 70,
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
            height: 70,
            color: new Color.fromRGBO(222, 39, 39, 30.0),
            child: new Center(
              child: new Image.asset('assets/doc.png', fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }

  Widget Documentos_ListItemRedAccent() {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
              padding: new EdgeInsets.symmetric(vertical: 10),
              width: 235,
              height: 70,
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
            height: 70,
            color: new Color.fromRGBO(143, 2, 2, 30.0),
            child: new Center(
              child: new Image.asset('assets/doc.png', fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
  
  Widget Biblioteca_Card(int ind){
    return new Container(
      child: new Card(
        elevation: 20,
        color: new Color.fromRGBO(222, 39, 39, 1.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              onTap: (){
                print('tapped $ind');
              },
              child: new Icon(Icons.share, size: 50),
            ),
            new Container(
              margin: new EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
              child: new Card(
                color: new Color.fromRGBO(225, 215, 215, 1),
                elevation: 20,
                child: new Container(
                  padding: new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: new Column(
                    children: <Widget>[
                      new Text('Nombre: Ensayo de algo', style: new TextStyle(fontSize: 12),),
                      new Text('Materia: Filosofía',style: new TextStyle(fontSize: 12))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
