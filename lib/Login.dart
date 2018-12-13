import 'package:flutter/material.dart';
import 'Auth.dart';

class Login extends StatefulWidget {
  Login({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginState();
}

class _LoginState extends State<Login> {

  final loginKey = new GlobalKey<FormState>();
  final registerKey = new GlobalKey<FormState>();


  String _email;
  String _password;
  String _confirmpassword;
  String _nombre;
  String _matricula;
  bool _whereiam = true;

  void returnToHome() {
    Navigator.pop(context);
  }

  void register() {
    setState(() {
      _whereiam = false;
    });
  }

  void registrar() async {
    print('registrar');
    final registerForm = registerKey.currentState;
    if(registerForm.validate() && _password==_confirmpassword){
      try{
        String userId=await widget.auth.createUserWithEmailAndPassword(_email, _password);
        //FirebaseUser user=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        print('Signed In UID: ${userId}');
        widget.onSignedIn();
      }catch(error){
        print('Error: $error');
      }
    }else{
      print('invalid');
    }
  }

  void login() async {
    print('login');
    //returnToHome();
    final loginForm = loginKey.currentState;
    if(loginForm.validate()){
      try{
        String userId=await widget.auth.signInWithEmailAndPassword(_email, _password);
        //FirebaseUser user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print('Signed In UID: ${userId}');
        widget.onSignedIn();
      }catch(error){
        print('Error: $error');
      }
    }else{
      print('invalid');
    }
  }

  void showLogin() {
    setState(() {
      _whereiam = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(home: new Scaffold(body: loginPart()));
  }

  List<Widget> buildInputs() {
    if (_whereiam) {
      return [
        new Container(
            padding: new EdgeInsets.symmetric(vertical: 20),
            child: new Form(
              key: loginKey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    decoration: new InputDecoration(
                        focusedBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: new Color.fromRGBO(255, 255, 255, 1.0))),
                        hintText: 'Correo',
                        hintStyle: new TextStyle(color: Colors.grey),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        fillColor: new Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(50),
                            borderSide:
                            new BorderSide(width: 0, color: Colors.black))),
                    //onSaved: (value) => _email = value,
                    onFieldSubmitted: (value) => _email = value,
                    style: new TextStyle(color: Colors.grey),
                  ),

                  new Padding(padding: new EdgeInsets.all(12.5),),

                  new TextFormField(
                    decoration: new InputDecoration(
                        focusedBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: new Color.fromRGBO(255, 255, 255, 1.0)
                            )
                        ),
                        hintText: 'Contraseña',
                        hintStyle: new TextStyle(color: Colors.grey),
                        contentPadding:
                        new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        fillColor: new Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(50),
                            borderSide: new BorderSide(width: 0, color: Colors.black)
                        )
                    ),
                    onFieldSubmitted: (value) => _password = value,
                    style: new TextStyle(color: Colors.grey),
                    obscureText: true,
                  ),
                ],
              ),
            )
        ),
        new Container(
          margin: new EdgeInsets.symmetric(vertical: 30),
          width: 500,
          height: 45,
          child: new RaisedButton(
            onPressed: login,
            color: new Color.fromRGBO(143, 2, 2, 1.0),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: const Text(
              '¡Ingresa!',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 20,
          ),
        ),
        new Container(
          padding: new EdgeInsets.symmetric(vertical: 3),
          child: new OutlineButton(
            onPressed: register,
            color: new Color.fromRGBO(255, 255, 255, 0.3),
            child: const Text(
              '¿No tienes cuenta? ¡Regístrate!',
              style: TextStyle(color: Colors.grey),
            ),
            borderSide: new BorderSide(
              color: new Color.fromRGBO(222, 39, 39, 1.0),
            ),
          ),
        )
      ];
    } else {
      return [
        new Container(
            //padding: new EdgeInsets.symmetric(vertical: 20),
            child: new Form(
              key: registerKey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    decoration: new InputDecoration(
                        focusedBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: new Color.fromRGBO(255, 255, 255, 1.0))),
                        hintText: 'Nombre y Apellido',
                        hintStyle: new TextStyle(color: Colors.grey),
                        contentPadding:
                        new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        fillColor: new Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(50),
                            borderSide: new BorderSide(width: 0, color: Colors.black))),
                    onFieldSubmitted: (value) => _nombre = value,
                    style: new TextStyle(color: Colors.grey),
                  ),
                  new Padding(padding: new EdgeInsets.all(12.5),),
                  new TextFormField(
                    decoration: new InputDecoration(
                        focusedBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: new Color.fromRGBO(255, 255, 255, 1.0))),
                        hintText: 'Matrícula',
                        hintStyle: new TextStyle(color: Colors.grey),
                        contentPadding:
                        new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        fillColor: new Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(50),
                            borderSide: new BorderSide(width: 0, color: Colors.black)
                        )
                    ),
                    onFieldSubmitted: (value) => _matricula = value,
                    style: new TextStyle(color: Colors.grey),
                  ),
                  new Padding(padding: new EdgeInsets.all(12.5),),
                  new TextFormField(
                    decoration: new InputDecoration(
                        focusedBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: new Color.fromRGBO(255, 255, 255, 1.0))),
                        hintText: 'Correo',
                        hintStyle: new TextStyle(color: Colors.grey),
                        contentPadding:
                        new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        fillColor: new Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(50),
                            borderSide: new BorderSide(width: 0, color: Colors.black))),
                    onFieldSubmitted: (value) => _email = value,
                    style: new TextStyle(color: Colors.grey),
                  ),
                  new Padding(padding: new EdgeInsets.all(12.5),),
                  new TextFormField(
                    decoration: new InputDecoration(
                        focusedBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: new Color.fromRGBO(255, 255, 255, 1.0))),
                        hintText: 'Contraseña',
                        hintStyle: new TextStyle(color: Colors.grey),
                        contentPadding:
                        new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        fillColor: new Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(50),
                            borderSide: new BorderSide(width: 0, color: Colors.black))),
                    onFieldSubmitted: (value) => _password = value,
                    style: new TextStyle(color: Colors.grey),
                  ),
                  new Padding(padding: new EdgeInsets.all(12.5),),
                  new TextFormField(
                    decoration: new InputDecoration(
                        focusedBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: new Color.fromRGBO(255, 255, 255, 1.0))),
                        hintText: 'Confirmar Contraseña',
                        hintStyle: new TextStyle(color: Colors.grey),
                        contentPadding:
                        new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        fillColor: new Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(50),
                            borderSide: new BorderSide(width: 0, color: Colors.black))),
                    onFieldSubmitted: (value) => _confirmpassword = value,
                    style: new TextStyle(color: Colors.grey),
                  )
                ],
              ),
            )
        ),
        new Container(
          margin: new EdgeInsets.symmetric(vertical: 40),
          width: 500,
          height: 45,
          child: new RaisedButton(
            onPressed: registrar,
            color: new Color.fromRGBO(143, 2, 2, 30.0),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: const Text(
              '¡Regístrame!',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 20,
          ),
        ),
        new Container(
          //padding: new EdgeInsets.symmetric(vertical: 40),
          child: new OutlineButton(
            onPressed: showLogin,
            color: new Color.fromRGBO(255, 255, 255, 0.3),
            child: const Text(
              '¿Ya tienes cuenta? ¡Ingresa!',
              style: TextStyle(color: Colors.grey),
            ),
            borderSide: new BorderSide(
              color: new Color.fromRGBO(222, 39, 39, 1.0),
            ),
          ),
        )
      ];
    }
  }

  Widget loginPart() {
    if (_whereiam) {
      return new SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(vertical: 30),
                child: new Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  width: 180,
                ),
              ),
              new Container(
                padding: new EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                decoration: new BoxDecoration(
                  color: new Color.fromRGBO(222, 39, 39, 1.0),
                ),
                child: new Column(
                  children: buildInputs(),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return new SingleChildScrollView(
        child: new Container(
          padding: new EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          decoration: new BoxDecoration(
            color: new Color.fromRGBO(222, 39, 39, 1.0),
          ),
          child: new Column(
            children: buildInputs(),
          ),
        ),
      );
    }
  }
}
