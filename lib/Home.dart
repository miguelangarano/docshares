import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String _nombre='default';
  String _materia='default';
  int _whereiam = 0;
  bool loggedin=false;
  String _filePath;
  List<Map<String, dynamic>> _myDocsList=new List();
  List<Map<String, dynamic>> _libraryDocsList=new List();
  final formKey=GlobalKey<FormState>();

  void home(){
    print('home');
    setState(() {
      _whereiam=0;
    });
  }

  void documentos(){
    print('documentos');
    _myDocsList.clear();
    getMyDocs();
    setState(() {
      _whereiam=1;
    });
  }

  void biblioteca(){
    print('biblioteca');
    _libraryDocsList.clear();
    getLibraryDocs();
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
      _filePath = await FilePicker.getFilePath(type: FileType.ANY);
      setState((){this._filePath = _filePath;});
      Fluttertoast.showToast(
          msg: 'Ubicación del archivo: $_filePath',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black
      );
    }catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  void uploadFile(){

    final form = formKey.currentState;
    print(form.validate());
    if (_filePath != '' && _filePath!=null && form.validate()) {
      form.save();
      File file=File(_filePath);
      String id=updateDatabase(form);
      print('el id: $id');
      final StorageReference storageReference=FirebaseStorage.instance.ref().child(id);
      final StorageUploadTask uploadTask=storageReference.putFile(file);
      print('subido');
      Fluttertoast.showToast(
          msg: 'Archivo subido con éxito',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black
      );
    }else{
      print('Debe especificar un archivo y llenar todos los campos');
      Fluttertoast.showToast(
          msg: 'Debe especificar un archivo y llenar todos los campos',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black
      );
    }
  }

  String updateDatabase(FormState key){
    DatabaseReference databaseReference=FirebaseDatabase.instance.reference();
    String id=randomAlphaNumeric(20);
    widget.auth.currentUser().then((value){
      var data={
      "nombre": _nombre,
      "materia": _materia,
      };

      var dataUno={
        "nombre": _nombre,
        "materia": _materia,
        "uid": value
      };

      print(data);
      print(dataUno);
      databaseReference.child('users').child(value).child(id).set(data);
      databaseReference.child('docs').child(id).set(dataUno);
    });

    return id;

  }

  void getMyDocs(){
    widget.auth.currentUser().then((value){
      DatabaseReference databaseReference=FirebaseDatabase.instance.reference();
      databaseReference.child('users').child(value).once().then((DataSnapshot snap){
        var fileids=snap.value.keys;
        var fileinfo=snap.value;
        int i=0;
        for(var fileid in fileids){
          var data={
            "id": fileid,
            "nombre": fileinfo[fileid]['nombre'],
            "materia": fileinfo[fileid]['materia'],
            "autor": value
          };
          _myDocsList.insert(i, data);
          i++;
        }
        print(_myDocsList);
        setState(() {
          _myDocsList=_myDocsList;
        });
      });
    });
  }

  void getLibraryDocs(){
    DatabaseReference databaseReference=FirebaseDatabase.instance.reference();
    databaseReference.child('docs').once().then((DataSnapshot snap){
      var fileids=snap.value.keys;
      var fileinfo=snap.value;
      int i=0;
      for(var fileid in fileids){
        var data={
          "id": fileid,
          "nombre": fileinfo[fileid]['nombre'],
          "materia": fileinfo[fileid]['materia'],
        };
        _libraryDocsList.insert(i, data);
        i++;
      }
      print(_libraryDocsList);
      setState(() {
        _libraryDocsList=_libraryDocsList;
      });
    });
  }

  void addToMyDocs(String id){
    print('added $id');
    DatabaseReference databaseReference=FirebaseDatabase.instance.reference();
    widget.auth.currentUser().then((value){
      var data={
        "nombre": _nombre,
        "materia": _materia,
      };

      print(data);
      databaseReference.child('users').child(value).child(id).set(data);
      Fluttertoast.showToast(
          msg: 'Libro añadido con éxito',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black
      );
    });
  }

  void openFile(String id){
    
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
                  child: Principal_Inputs(),
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
          itemCount: _libraryDocsList.length,
          itemBuilder: (BuildContext context, int index){
            var obj={
              "nombre": _libraryDocsList[index]['nombre'],
              "materia": _libraryDocsList[index]['materia'],
              "id": _libraryDocsList[index]['id']
            };

            return Biblioteca_Card(index, obj);
          }
      ),
    );
  }

  Widget Principal_Inputs() {
    return new Container(
          margin: new EdgeInsets.symmetric(vertical: 20),
          child: new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                new TextFormField(
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
                  onSaved: (value) => _nombre = value,
                  style: new TextStyle(color: Colors.white),
                ),
                new Padding(padding: new EdgeInsets.all(10)),
                new TextFormField(
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
                  onSaved: (value) => _materia = value,
                  style: new TextStyle(color: Colors.white),
                )
              ],
            ),
          )
      );
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
      onPressed: uploadFile,
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
    print('tamaños es');
    print(_myDocsList.length);
    return new ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: _myDocsList.length,
      itemBuilder: (BuildContext context, int index) {
        var obj={
          "nombre": _myDocsList[index]['nombre'],
          "materia": _myDocsList[index]['materia'],
          "autor": _myDocsList[index]['autor']
        };

        if(index%2==0){
          return Documentos_ListItemRedAccent(obj);
        }else{
          return Documentos_ListItemRed(obj);
        }
      },
    );
  }

  Widget Documentos_ListItemRed(var obj) {
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
                  new Text('Nombre: '+obj['nombre'], style: new TextStyle(color: Colors.white),),
                  new Text('Materia: '+obj['materia'], style: new TextStyle(color: Colors.white),),
                  new Padding(padding: new EdgeInsets.all(3)),
                  new Text('Subido por: '+obj['autor'], style: new TextStyle(color: Colors.white, fontSize: 8),)
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

  Widget Documentos_ListItemRedAccent(var obj) {
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
                  new Text('Nombre: '+obj['nombre'], style: new TextStyle(color: Colors.white),),
                  new Text('Materia: '+obj['materia'], style: new TextStyle(color: Colors.white),),
                  new Padding(padding: new EdgeInsets.all(3)),
                  new Text('Subido por: '+obj['autor'], style: new TextStyle(color: Colors.white, fontSize: 8),)
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
  
  Widget Biblioteca_Card(int ind, var obj){
    return new Container(
      child: new Card(
        elevation: 20,
        color: new Color.fromRGBO(222, 39, 39, 1.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              onTap: ()=>addToMyDocs(obj['id']),
              child: new Icon(Icons.share, size: 50),
            ),
            new GestureDetector(
              onTap: ()=>openFile(obj['id']),
              child: new Container(
                margin: new EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                child: new Card(
                  color: new Color.fromRGBO(225, 215, 215, 1),
                  elevation: 20,
                  child: new Container(
                    padding: new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: new Column(
                      children: <Widget>[
                        new Text('Nombre: '+obj['nombre'], style: new TextStyle(fontSize: 12),),
                        new Text('Materia: '+obj['materia'],style: new TextStyle(fontSize: 12))
                      ],
                    ),
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
