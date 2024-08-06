import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _heightSliderValue = 170;
  double _weightSliderValue = 70;

  // Normally in Flutter , the global variable/ state is declared with _
  var _bmi = 0;
  var _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "BMI Calculator",
              style: TextStyle(color: Colors.red, fontSize: 32),
            ),
            Text("We care about your health"),
            Image.asset("images/bmi.jpeg"),
            Text("Height ( ${_heightSliderValue.round()} cm)"),
            Slider(
              value: _heightSliderValue,
              max: 220,
              min:40,
              onChanged: (double value) {
                setState(() {
                  _heightSliderValue = value;
                });
              },
            ),
            Text("Weight (${_weightSliderValue.round()} kg)"),
            Slider(
              value: _weightSliderValue,
              max:150,
              min:30,
              onChanged: (double value){
                setState(() {
                  _weightSliderValue = value;
                });
              },
            ),
            _bmi != 0 ? Text("Your BMI is $_bmi") : SizedBox(),
            SizedBox(height: 8,),
            Text(_message),
            SizedBox(height: 8,),
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(Colors.red)
              ),
              onPressed: () {

                // (weight in kg) / (height in m)^2
                var bmiTemp = _weightSliderValue / pow((_heightSliderValue / 100),2);
                var messageTemp = "";

                if (bmiTemp < 18){
                  messageTemp = "You are underweight";
                } else if (bmiTemp < 25) {
                  messageTemp = "You are normal";
                } else if (bmiTemp < 30) {
                  messageTemp = "You are overweight";
                } else if (bmiTemp < 35) {
                  messageTemp = "You are obese";
                } else {
                  messageTemp = "You are extremely obese";
                }

                print(bmiTemp);

                // Assign bmiTemp into _bmi
                // Assigning bmiTemp.round() into _bmi WITHOUT refreshing the UI
                //_bmi = bmiTemp.round();

                // ASSIGN AND REFRESH THE UI

                setState(() {
                  _bmi = bmiTemp.round(); // round transform double to integer
                  _message = messageTemp;
                });

              },
              label: Text("Calculate BMI"),
              icon: Icon(Icons.favorite),
            )
          ],
        ),
      ),
    );
  }
}
