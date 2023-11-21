import 'package:flutter/material.dart';
import 'dicepage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const PlayerSelectionScreen(),
  ));
}

class PlayerSelectionScreen extends StatelessWidget {
  const PlayerSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Select Number of Players')),
        backgroundColor: Colors.blueGrey, // Set app bar background color
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey,
              Colors.white
            ], // Use a gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlayerButton(
                onPressed: () => startGame(context, 2),
                text: '2 Players',
              ),
              const SizedBox(height: 16), // Add some spacing between buttons
              PlayerButton(
                onPressed: () => startGame(context, 3),
                text: '3 Players',
              ),
              const SizedBox(height: 16),
              PlayerButton(
                onPressed: () => startGame(context, 4),
                text: '4 Players',
              ),
            ],
          ),
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

class PlayerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const PlayerButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey, // Set text color
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 16), // Add padding
      ),
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }
}
