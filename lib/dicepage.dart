// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:math';

class PlayerSelectionScreen extends StatelessWidget {
  const PlayerSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Number of Players'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => startGame(context, 2),
              child: const Text('2 Players'),
            ),
            ElevatedButton(
              onPressed: () => startGame(context, 3),
              child: const Text('3 Players'),
            ),
            ElevatedButton(
              onPressed: () => startGame(context, 4),
              child: const Text('4 Players'),
            ),
          ],
        ),
      ),
    );
  }

  void startGame(BuildContext context, int numberOfPlayers) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiceApp(numberOfPlayers: numberOfPlayers),
      ),
    );
  }
}

class DiceApp extends StatelessWidget {
  final int numberOfPlayers;

  const DiceApp({super.key, required this.numberOfPlayers});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: DicePage(numberOfPlayers: numberOfPlayers),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  final int numberOfPlayers;

  const DicePage({super.key, required this.numberOfPlayers});

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

  // Helper method to check if the current player is a computer player
  bool isComputerPlayer(String player) {
    return player.startsWith("Computer");
  }

  void rollDice(String diceName, int Function() updateDiceValue) {
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

      // If the current player is a computer player, auto-roll the dice after a short delay
      if (isComputerPlayer(currentPlayer)) {
        Future.delayed(const Duration(seconds: 2), () {
          rollAllDice();
        });
      }
    });
  }

  void rollAllDice() {
    // Roll dice for the current player
    switch (currentPlayer) {
      case "Player 1":
        rollDice("Top Left", () {
          topLeft = Random().nextInt(6) + 1;
          return topLeft;
        });

        rollDice("Top Right", () {
          topRight = Random().nextInt(6) + 1;
          return topRight;
        });

        rollDice("Bottom Left", () {
          bottomLeft = Random().nextInt(6) + 1;
          return bottomLeft;
        });

        rollDice("Bottom Right", () {
          bottomRight = Random().nextInt(6) + 1;
          return bottomRight;
        });
        break;
      case "Player 2":
        rollDice("Top Right", () {
          topRight = Random().nextInt(6) + 1;
          return topRight;
        });
        break;
      case "Player 3":
        rollDice("Bottom Left", () {
          bottomLeft = Random().nextInt(6) + 1;
          return bottomLeft;
        });
        break;
      case "Player 4":
        rollDice("Bottom Right", () {
          bottomRight = Random().nextInt(6) + 1;
          return bottomRight;
        });
        break;
      default:
        break;
    }
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DiceButton("Top Left", () => topLeft, () {
              topLeft = Random().nextInt(6) + 1;
              return topLeft;
            }),
            DiceButton("Top Right", () => topRight, () {
              topRight = Random().nextInt(6) + 1;
              return topRight;
            }),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DiceButton("Bottom Left", () => bottomLeft, () {
              bottomLeft = Random().nextInt(6) + 1;
              return bottomLeft;
            }),
            DiceButton("Bottom Right", () => bottomRight, () {
              bottomRight = Random().nextInt(6) + 1;
              return bottomRight;
            }),
          ],
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: rollAllDice,
          child: const Text('Roll All Dice'),
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

  Widget DiceButton(String name, int Function() valueFunction,
      int Function() updateFunction) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueGrey[800],
          elevation: 6.0,
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () => rollDice(name, updateFunction),
        child: Image.asset(
          'images/dice${valueFunction()}.png',
          height: 100.0,
          width: 100.0,
        ),
      ),
    );
  }
}
