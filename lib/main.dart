import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const DiceApp(),
  ));
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],

        // appBar: AppBar(
        //   title: const Text(
        //     ' Dice App',
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   centerTitle: true,
        // ),
        body: const DicePage(),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  DicePageState createState() => DicePageState();
}

class DicePageState extends State<DicePage> {
  String currentPlayer = "Player 1";
  String lastRolledDice = "Roll a dice!";
  int topLeft = 1;
  int topRight = 6;
  int bottomLeft = 6;
  int bottomRight = 1;
  Map<String, int> playerScores = {
    "Player 1": 0,
    "Player 2": 0,
    "Player 3": 0,
    "Player 4": 0,
  };

  void rollDice(String diceName, Function updateDiceValue) {
    int newValue = updateDiceValue();

    setState(() {
      lastRolledDice = diceName;
      playerScores[currentPlayer] = newValue;

      // Rotate to the next player
      if (currentPlayer == "Player 1") {
        currentPlayer = "Player 2";
      } else if (currentPlayer == "Player 2") {
        currentPlayer = "Player 3";
      } else if (currentPlayer == "Player 3") {
        currentPlayer = "Player 4";
      } else {
        currentPlayer = "Player 1";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$currentPlayer\'s Turn',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          'Last rolled dice: $lastRolledDice',
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            diceButton("Top Left", () => topLeft, () {
              topLeft = Random().nextInt(6) + 1;
              return topLeft;
            }),
            diceButton("Top Right", () => topRight, () {
              topRight = Random().nextInt(6) + 1;
              return topRight;
            }),
          ],
        ),
        Row(
          children: [
            diceButton("Bottom Left", () => bottomLeft, () {
              bottomLeft = Random().nextInt(6) + 1;
              return bottomLeft;
            }),
            diceButton("Bottom Right", () => bottomRight, () {
              bottomRight = Random().nextInt(6) + 1;
              return bottomRight;
            }),
          ],
        ),
        const SizedBox(height: 20.0),
        for (var player in playerScores.keys)
          Text(
            '$player Score: ${playerScores[player]}',
            style: const TextStyle(
              color: Colors.cyan,
              fontSize: 20,
            ),
          ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Expanded diceButton(
      String name, Function valueFunction, Function updateFunction) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[800],
            elevation: 6.0,
            padding: const EdgeInsets.all(16.0),
          ),
          onPressed: () => rollDice(name, updateFunction),
          child: Image.asset(
            'images/dice${valueFunction()}.png',
          ),
        ),
      ),
    );
  }
}
