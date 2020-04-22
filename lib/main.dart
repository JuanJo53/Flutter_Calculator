import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caluladora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'Calculadora Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String operacion="";
  String resultado="";
  String expresion="";

  TextEditingController expArt = TextEditingController();
  TextEditingController numReal = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: expArt=TextEditingController(text: operacion),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 25.0,
              ),
              enabled: false,
            ),
            TextField(
              controller: numReal,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20.0,
              ),
              enabled: false,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                funcionAvanzada('INV'),
                funcionAvanzada('DEG'),
                funcionAvanzada('sin'),
                funcionAvanzada('cos'),
                funcionAvanzada('tan'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                funcionAvanzada('%'),
                funcionAvanzada('ln'),
                funcionAvanzada('log'),
                funcionAvanzada('√'),
                funcionAvanzada('^'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                funcionAvanzada('π'),
                funcionAvanzada('e'),
                funcionAvanzada('('),
                funcionAvanzada(')'),
                funcionAvanzada('!'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('7'),
                Digito('8'),
                Digito('9'),
                funcionBasica('DEL'),
                funcionBasica('AC'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('4'),
                Digito('5'),
                Digito('6'),
                funcionBasica('×'),
                funcionBasica('÷'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('1'),
                Digito('2'),
                Digito('3'),
                funcionBasica('+'),
                funcionBasica('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('0'),
                Digito('.'),
                Digito(''),
                funcionBasica('Ans'),
                funcionBasica('='),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget Digito(msg){
    return Container(
      width:72.0,
      color: Colors.black54,
      child: FlatButton(
          onPressed: (){
            setState(() {
              //TODO: Controlar el punto.
              operacion+=msg;
            });
          },
          child: Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.white),)
      ),
    );
  }
  Widget funcionBasica(msg){
    return Container(
      width:72.0,
      color: Colors.black54,
      child: FlatButton(
          onPressed: (){
            setState(() {
              if(msg=="AC"){
                operacion="";
              }else if(msg=='='){
                solucionar();
              }else if(msg=='Ans'){
                asigAns();
              }else if(msg=='DEL'){
                operacion=operacion.substring(0,operacion.length-1);
              }else{
                operacion+=msg;
              }
            });
          },
          child: Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.white),)
      ),
    );
  }
  Widget funcionAvanzada(msg){
    return Container(
      width: 72.0,
      color: Colors.cyan,
      child: FlatButton(
          onPressed: (){
            setState(() {
              if (msg=='sin'||msg=='cos'||msg=='tan'||msg=='log'||msg=='ln'||msg=='√'){
                  operacion+=msg+"(";
              }else if(msg=='INV'){

              }else{
                operacion+=msg;
              }
            });
          },
          child: Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.white),)
      ),
    );
  }
  void solucionar(){
    //TODO: Hacer funcion para resolver la operacion ingresada. Primero verificar si no hay errores en la expresion.
  }

  void asigAns() {
    //TODO: Hacer funcion para asignar y recuperar la respuesta anterior.
  }
}
