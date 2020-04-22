import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

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
  String prevRes="";
  String expresion="";
  int openController=0;
  int closeController=0;
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
              controller: numReal=TextEditingController(text: resultado),
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
                Digito('00'),
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
                prevRes=resultado;
                resultado="";
                openController=0;
                closeController=0;
              }else if(msg=='='){
                if(closeController==openController){
                  solucionar();
                }else{
                  resultado='Syntax Error';
                }
              }else if(msg=='Ans'){
                //TODO: Mejorar para poder usar con funciones complejas.
                operacion=msg;
              }else if(msg=='DEL'){
                if(operacion==""){
                  print("Operacion Vacia");
                }else if(operacion.substring(operacion.length-1)=="(" && operacion!=""){
                  operacion=operacion.substring(0,operacion.length-2);
                }else if(operacion.substring(operacion.length-1)!="(" && operacion!=""){
                  operacion=operacion.substring(0,operacion.length-1);
                }else if(operacion.substring(operacion.length-1)=="("){
                  operacion=operacion.substring(0,operacion.length-1);
                  openController--;
                  print(openController);
                }else if(operacion.substring(operacion.length-1)==")"){
                  operacion=operacion.substring(0,operacion.length-1);
                  closeController--;
                  print(closeController);
                }
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
                  openController++;
              }else if(msg=='INV'){
                changeINVfunctions();
              }else if(msg=='('){
                operacion+=msg;
                openController++;
              }else if(msg==')'){
                operacion+=msg;
                closeController++;
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
    expresion=operacion;
    expresion=expresion.replaceAll('×', '*');
    expresion=expresion.replaceAll('÷', '/');
    expresion=expresion.replaceAll('π',math.pi.toString());
    expresion=expresion.replaceAll('e',math.e.toString());
    expresion=expresion.replaceAll('√(','sqrt(');
    expresion=expresion.replaceAll('log(','log(10,');
    expresion=expresion.replaceAll('Ans', prevRes);
    try{
      Parser p = Parser();
      Expression exp = p.parse(expresion);
      ContextModel cm = ContextModel();
      resultado='${exp.evaluate(EvaluationType.REAL, cm)}';
      prevRes=resultado;
    }catch(e){
      resultado="Error: "+e;
    }
  }
  void changeINVfunctions(){
    //TODO: Hacer funcion que habilite las funciones inversas.
  }
}
