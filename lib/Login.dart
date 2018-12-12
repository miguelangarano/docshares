import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginState();
}

class _LoginState extends State<Login> {
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

  void registrar() {
    print('registrar');
  }

  void login() {
    print('login');
    returnToHome();
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
            child: new TextFormField(
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
              validator: (value) =>
                  value.isEmpty ? 'Correo no puede estar vacio' : null,
              onSaved: (value) => _email = value,
              style: new TextStyle(color: Colors.grey),
            )),
        new Container(
          child: new TextFormField(
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
            validator: (value) =>
                value.isEmpty ? 'Contraseña no puede estar vacio' : null,
            onSaved: (value) => _password = value,
            style: new TextStyle(color: Colors.grey),
          ),
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
            child: new TextFormField(
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
          validator: (value) =>
              value.isEmpty ? 'Nombre no puede estar vacio' : null,
          onSaved: (value) => _nombre = value,
          style: new TextStyle(color: Colors.grey),
        )),
        new Container(
            padding: new EdgeInsets.symmetric(vertical: 20),
            child: new TextFormField(
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
                      borderSide: new BorderSide(width: 0, color: Colors.black))),
              validator: (value) =>
              value.isEmpty ? 'Matrícula no puede estar vacio' : null,
              onSaved: (value) => _matricula = value,
              style: new TextStyle(color: Colors.grey),
            )),
        new Container(
            //padding: new EdgeInsets.symmetric(vertical: 10),
            child: new TextFormField(
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
          validator: (value) =>
              value.isEmpty ? 'Correo no puede estar vacio' : null,
          onSaved: (value) => _email = value,
          style: new TextStyle(color: Colors.grey),
        )),
        new Container(
          padding: new EdgeInsets.symmetric(vertical: 20),
          child: new TextFormField(
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
            validator: (value) =>
                value.isEmpty ? 'Contraseña no puede estar vacio' : null,
            onSaved: (value) => _password = value,
            style: new TextStyle(color: Colors.grey),
          ),
        ),
        new Container(
          child: new TextFormField(
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
            validator: (value) => value.isEmpty
                ? 'Confirmar contraseña no puede estar vacio'
                : null,
            onSaved: (value) => _confirmpassword = value,
            style: new TextStyle(color: Colors.grey),
          ),
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
      return new Container(
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
            new SingleChildScrollView(
              child: new Container(
                padding: new EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                decoration: new BoxDecoration(
                  color: new Color.fromRGBO(222, 39, 39, 1.0),
                ),
                child: new Column(
                  children: buildInputs(),
                ),
              ),
            )
          ],
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
