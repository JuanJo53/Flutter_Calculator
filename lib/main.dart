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

  bool invEnabled=false;

  String sen='sin';
  String cos='cos';
  String tan='tan';
  String sqrt='√';
  String cube='∛';

  bool focus=false;

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
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
                INVbtn('INV',sizeScreen),
                funcionAvanzada('½',sizeScreen),
                funcionAvanzada(sen,sizeScreen),
                funcionAvanzada(cos,sizeScreen),
                funcionAvanzada(tan,sizeScreen),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                funcionAvanzada('%',sizeScreen),
                funcionAvanzada('ln',sizeScreen),
                funcionAvanzada('log',sizeScreen),
                funcionAvanzada(sqrt,sizeScreen),
                funcionAvanzada(cube,sizeScreen),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                funcionAvanzada('π',sizeScreen),
                funcionAvanzada('e',sizeScreen),
                funcionAvanzada('(',sizeScreen),
                funcionAvanzada(')',sizeScreen),
                funcionAvanzada('^',sizeScreen),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('7',sizeScreen),
                Digito('8',sizeScreen),
                Digito('9',sizeScreen),
                funcionBasica('DEL',sizeScreen),
                funcionBasica('AC',sizeScreen),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('4',sizeScreen),
                Digito('5',sizeScreen),
                Digito('6',sizeScreen),
                funcionBasica('×',sizeScreen),
                funcionBasica('÷',sizeScreen),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('1',sizeScreen),
                Digito('2',sizeScreen),
                Digito('3',sizeScreen),
                funcionBasica('+',sizeScreen),
                funcionBasica('-',sizeScreen),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Digito('0',sizeScreen),
                Digito('.',sizeScreen),
                Digito('00',sizeScreen),
                funcionBasica('Ans',sizeScreen),
                funcionBasica('=',sizeScreen),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget Digito(msg,sizeScreen){
    return Container(
      width:sizeScreen.width/5,
      color: Colors.black54,
      child: FlatButton(
          onPressed: (){
            setState(() {
              if(msg=='.'){
                if(operacion.isEmpty){
                  operacion+=msg;
                }else if(operacion.substring(operacion.length-1)!="."){
                  operacion+=msg;
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
  Widget funcionBasica(msg,sizeScreen){
    return Container(
      width:sizeScreen.width/5,
      color: Colors.black54,
      child: FlatButton(
          onPressed: (){
            setState(() {
              try{
                if(msg=='Ans'&&!prevRes.isEmpty){
                  operacion+=msg;
                }else{
                  if(!operacion.isEmpty){
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
                    }else if(msg=='DEL'){
                      DELfunction(msg);
                    }else{
                      if(msg!='Ans')
                        operacion+=msg;
                    }
                  }else{
                    print("Operacion Vacia");
                  }
                }
                print("abiertos: "+openController.toString());
                print("cerrados: "+closeController.toString());
              }catch(e){
                resultado='Syntax Error';
              }
            });
          },
          child: Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.white),)
      ),
    );
  }
  Widget funcionAvanzada(msg,sizeScreen){
    return Container(
      width: sizeScreen.width/5,
      color: Colors.cyan,
      child: RawMaterialButton(
          onPressed: (){
            setState(() {
              if(msg==')'&&openController>closeController){
               operacion+=msg;
               closeController++;
              }else{
                if (msg=='tan⁻¹'||msg=='cos⁻¹'||msg=='sin⁻¹'||msg=='sin'||msg=='cos'||msg=='tan'||msg=='log'||msg=='ln'||msg=='√'||msg=='∛'){
                  operacion+=msg+"(";
                  openController++;
                }else if(msg=='('){
                  operacion+=msg;
                  openController++;
                }else if(msg=='x²'){
                  if(!operacion.isEmpty){
                    operacion+='^2';
                  }
                }else if(msg=='x³'){
                  if(!operacion.isEmpty){
                    operacion+='^3';
                  }
                }else if(msg!=')'){
                  operacion+=msg;
                }
              }
            });
          },
          child: Text(msg,style: TextStyle(fontSize: 17.0,color: Colors.white,),),
          splashColor: Colors.blueAccent,
          focusColor: Colors.amberAccent,
      ),
    );
  }
  Widget INVbtn(msg,Size sizeScreen){
    return Container(
      width: sizeScreen.width/5,
      color: focus ? Colors.blue :Colors.cyan,
      child: RawMaterialButton(
        onPressed: (){
          setState(() {
            changeINVfunctions();
          });
        },
        child: Text(msg,style: TextStyle(fontSize: 17.0,color: Colors.white,),),
        splashColor: Colors.blueAccent,
        focusColor: Colors.amberAccent,
      ),
    );
  }
  void DELfunction(String msg){
    int tamOperacion=operacion.length;
    print("tamaño: "+tamOperacion.toString());
    if(tamOperacion>5){
      if(operacion.substring(tamOperacion-1)=='('){
        if(operacion.substring(tamOperacion-3)=='ln('){
          operacion=operacion.substring(0,operacion.length-3);
          openController--;
        }else if(operacion.substring(tamOperacion-2)=='√('||operacion.substring(tamOperacion-2)=='∛(') {
          operacion = operacion.substring(0, operacion.length - 2);
          openController--;
        }else if(operacion.substring(tamOperacion-4)=='log('||operacion.substring(tamOperacion-4)=='cos('
            ||operacion.substring(tamOperacion-4)=='sin('||operacion.substring(tamOperacion-4)=='tan('){
          operacion=operacion.substring(0,operacion.length-4);
          openController--;
        }else if(operacion.substring(tamOperacion-5)=='os⁻¹('||operacion.substring(tamOperacion-5)=='in⁻¹('
            ||operacion.substring(tamOperacion-5)=='an⁻¹('){
          operacion=operacion.substring(0,operacion.length-6);
          openController--;
        }else{
          if(operacion.substring(tamOperacion-1)=='('){
            operacion=operacion.substring(0,operacion.length-1);
            openController--;
          }else if(operacion.substring(tamOperacion-1)==')'){
            operacion=operacion.substring(0,operacion.length-1);
            closeController--;
          }else{
            operacion=operacion.substring(0,operacion.length-1);
          }
        }
      }else if(operacion.substring(tamOperacion-1)==')'){
        operacion=operacion.substring(0,operacion.length-1);
        closeController--;
      }else if(operacion.substring(tamOperacion-3)=='Ans'){
        operacion=operacion.substring(0,operacion.length-3);
      }else{
        operacion=operacion.substring(0,operacion.length-1);
      }
    }else if(tamOperacion==5){
      if(operacion.substring(tamOperacion-5)=='os⁻¹('||operacion.substring(tamOperacion-5)=='in⁻¹('
          ||operacion.substring(tamOperacion-5)=='an⁻¹('){
        operacion=operacion.substring(0,operacion.length-6);
        openController--;
      }else{
        if(operacion.substring(tamOperacion-1)=='('){
          operacion=operacion.substring(0,operacion.length-1);
          openController--;
        }else if(operacion.substring(tamOperacion-1)==')'){
          operacion=operacion.substring(0,operacion.length-1);
          closeController--;
        }else{
          operacion=operacion.substring(0,operacion.length-1);
        }
      }
    }else if(tamOperacion==4){
      if(operacion.substring(tamOperacion-4)=='log('||operacion.substring(tamOperacion-4)=='cos('
          ||operacion.substring(tamOperacion-4)=='sin('||operacion.substring(tamOperacion-4)=='tan('){
        operacion=operacion.substring(0,operacion.length-4);
        openController--;
      }else {
        if(operacion.substring(tamOperacion-1)=='('){
          operacion=operacion.substring(0,operacion.length-1);
          openController--;
        }else if(operacion.substring(tamOperacion-1)==')'){
          operacion=operacion.substring(0,operacion.length-1);
          closeController--;
        }else{
          operacion=operacion.substring(0,operacion.length-1);
        }
      }
    }else if(tamOperacion==3){
      if(operacion.substring(tamOperacion-3)=='ln('){
        operacion=operacion.substring(0,operacion.length-3);
        openController--;
      }else{
        if(operacion.substring(tamOperacion-1)=='('){
          operacion=operacion.substring(0,operacion.length-1);
          openController--;
        }else if(operacion.substring(tamOperacion-1)==')'){
          operacion=operacion.substring(0,operacion.length-1);
          closeController--;
        }else{
          operacion=operacion.substring(0,operacion.length-1);
        }
      }
    }else if(tamOperacion==2){
      if(operacion.substring(tamOperacion-2)=='√('||operacion.substring(tamOperacion-2)=='∛(') {
        operacion = operacion.substring(0, operacion.length - 2);
        openController--;
      }else{
        if(operacion.substring(tamOperacion-1)=='('){
          operacion=operacion.substring(0,operacion.length-1);
          openController--;
        }else if(operacion.substring(tamOperacion-1)==')'){
          operacion=operacion.substring(0,operacion.length-1);
          closeController--;
        }else{
          operacion=operacion.substring(0,operacion.length-1);
        }
      }
    }else{
      if(operacion.substring(tamOperacion-1)=='('){
        operacion=operacion.substring(0,operacion.length-1);
        openController--;
      }else if(operacion.substring(tamOperacion-1)==')'){
        operacion=operacion.substring(0,operacion.length-1);
        closeController--;
      }else{
        operacion=operacion.substring(0,operacion.length-1);
      }
    }
  }
  void solucionar(){
    expresion=operacion;
    expresion=expresion.replaceAll('½','1/2');
    expresion=expresion.replaceAll('×', '*');
    expresion=expresion.replaceAll('×+', '*');
    expresion=expresion.replaceAll('÷', '/');
    expresion=expresion.replaceAll('π',math.pi.toString());
    expresion=expresion.replaceAll('e',math.e.toString());
    expresion=expresion.replaceAll('∛(','nrt(3,');
    expresion=expresion.replaceAll('√(','sqrt(');
    expresion=expresion.replaceAll('log(','log(10,');
    expresion=expresion.replaceAll(')(',')*(');
    expresion=expresion.replaceAll('Ans', prevRes);
    expresion=expresion.replaceAll('sin⁻¹(', 'arcsin(');
    expresion=expresion.replaceAll('cos⁻¹(', 'arccos(');
    expresion=expresion.replaceAll('tan⁻¹(', 'arctan(');
    print(expresion);
    try{
      Parser p = Parser();
      Expression exp = p.parse(expresion);
      print(exp.simplify());
      ContextModel cm = ContextModel();
      resultado='${exp.evaluate(EvaluationType.REAL, cm)}';
      prevRes=resultado;
    }catch(e){
      resultado="Error: "+e;
    }
  }
  void changeINVfunctions(){
    if(invEnabled){
      invEnabled=false;
      sen='sin';
      cos='cos';
      tan='tan';
      sqrt='√';
      cube='∛';
      focus=false;
    }else{
      invEnabled=true;
      sen='sin⁻¹';
      cos='cos⁻¹';
      tan='tan⁻¹';
      sqrt='x²';
      cube='x³';
      focus=true;
    }
  }
}
