import 'package:calculator_404/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator404(),
    );
  }
}

class Calculator404 extends StatefulWidget {
  const Calculator404({super.key});

  @override
  State<Calculator404> createState() => _Calculator404State();
}

class _Calculator404State extends State<Calculator404> {
  double num1= 0.0;
  double num2= 0.0;
  var input= "";
  var output= "";
  var operation= "";
  var hideinput= false;
  var outputSize= 32.0;
  onButtonClick(value){
    if(value == "AC"){
      input = "";
      output = "";
    }
    else if(value == "C"){
     if (input.isNotEmpty) {
      input = input.substring(0, input.length -1);
     }
    }
    else if(value == "="){
      if (input.isNotEmpty) {
      var userInput = input;
      userInput = input.replaceAll("x", "*");
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
      if (output.endsWith(".0")){
      output = output.substring(0, output.length -2);
      }
      input = output;
      hideinput = true;
      outputSize = 52.0;
      }
    }
    else{
      input = input + value;
      hideinput = false;
      outputSize = 32.0;
    }

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: baseColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(hideinput ? "" : input,style: const TextStyle(
                    fontSize: 32,
                  ),
                  ),
                  const SizedBox(
                    height: 30,
                    width: 20,
                  ),
                   Text(output,style:  TextStyle(
                    fontSize: outputSize,
                  ),
                  ),
                   const SizedBox(
                    height: 80,
                    width: 25,
                  ),
                ],
              ),
            ),
            ),
             Row(
              children: [
               button(text:"AC",tcolor: Colors.orange),
               button(text:"C",tcolor: Colors.orange),
               button(text:"/",tcolor: Colors.orange),
              ],
            ),
            Row(
              children: [
                button(text:"7"),
               button(text:"8"),
               button(text:"9"),
               button(text:"x",tcolor: Colors.orange),
              ],
            ),
            Row(
              children: [
                button(text:"4"),
               button(text:"5"),
               button(text:"6"),
               button(text:"-",tcolor: Colors.orange),
              ],
            ),
            Row(
              children: [
                button(text:"1"),
               button(text:"2"),
               button(text:"3"),
               button(text:"+",tcolor: Colors.orange),
              ],
            ),
            Row(
              children: [
               button(text:"%"),
               button(text:"0"),
               button(text:"."),
               button(text:"=",tcolor: Colors.orange),
              ],
            ),
      ],
      ),
    );
  }


  Widget button({
    text = "1",tcolor = Colors.black, }
  ){
    return Expanded(child:  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow:
                    [ 
                      BoxShadow(
                          color: Colors.grey[500]!,
                          offset: const Offset(8, 8),
                          blurRadius: 20,
                          spreadRadius: 1,    
                        ),  
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-8, -8),
                          blurRadius: 20,
                          spreadRadius: 1,
                        ), 
                      ],

                    ),
                    margin:  const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(22),
                        backgroundColor: baseColor),
                      onPressed: () => onButtonClick(text), child: Text(
                        text,
                        style: TextStyle(
                          color: tcolor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ),
                  );
  }
}