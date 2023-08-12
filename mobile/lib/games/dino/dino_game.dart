import 'package:flutter/material.dart';

class MyDinoApp extends StatelessWidget {
  const MyDinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dino',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DinoGame(),
    );
  }
}

class DinoGame extends StatelessWidget {
  const DinoGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dino',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pushNamed(context, RoutesManager.gameScreen);
          },
          child: const Text(
            'Play',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
