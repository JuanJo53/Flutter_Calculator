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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController expArt = TextEditingController();
    TextEditingController numReal = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: expArt,
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
                Digito('AC'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('4'),
                Digito('5'),
                Digito('6'),
                funcionBasica('×'),
                Digito('÷'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('1'),
                Digito('2'),
                Digito('3'),
                funcionBasica('+'),
                Digito('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('0'),
                Digito('.'),
                Digito(' '),
                funcionBasica('Ans'),
                Digito('='),
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

            });
          },
          child: Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.white),)
      ),
    );
  }
  Widget funcionBasica(msg){
    return Container(
      width:72.0,
      decoration: BoxDecoration(
        color: Colors.black54,
        border: Border(
          left: BorderSide(
            color: Colors.white,
            width: 2.0,
          )
        )
      ),
      child: FlatButton(
          onPressed: (){

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

          },
          child: Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.white),)
      ),
    );
  }
}
