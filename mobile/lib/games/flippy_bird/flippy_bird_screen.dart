import 'dart:async';
import 'package:flutter/material.dart';

class FlappyBirdApp extends StatelessWidget {
  const FlappyBirdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Bird',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FlappyBirdHomePage(),
    );
  }
}

class FlappyBirdHomePage extends StatefulWidget {
  const FlappyBirdHomePage({super.key});

  @override
  _FlappyBirdHomePageState createState() => _FlappyBirdHomePageState();
}

class _FlappyBirdHomePageState extends State<FlappyBirdHomePage> {
  double birdYAxis = 0;
  double birdSize = 50;
  double screenHeight = 0;
  double screenWidth = 0;
  double gravity = 2.5;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  double barrierXOne = 1.5;
  double barrierXTwo = 2.8;
  double barrierWidth = 100;
  double barrierHeight = 200;
  bool gameHasStarted = false;
  int score = 0;
  int bestScore = 0;
  bool gameOver = false;
  Timer? timer;

  void jump() {
    if (gameOver) {
      resetGame();
    } else {
      setState(() {
        time = 0;
        initialHeight = birdYAxis;
      });
    }
  }

  void resetGame() {
    setState(() {
      birdYAxis = 0;
      birdSize = 50.0;
      barrierXOne = 1.5;
      barrierXTwo = 2.8;
      score = 0;
      gameOver = false;
    });
    startGame();
  }

  void startGame() {
    gameHasStarted = true;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    initialHeight = birdYAxis;
    timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
        barrierXOne -= 0.05;
        barrierXTwo -= 0.05;
      });
      checkGameOver();
      updateScore();
    });
  }

  void checkGameOver() {
    if (birdYAxis > screenHeight || birdYAxis < 0) {
      timer?.cancel();
      gameOver = true;
      if (score > bestScore) {
        bestScore = score;
      }
    }
    if ((barrierXOne < 0 && barrierXOne > -0.1 && birdXAxis == 0) ||
        (barrierXTwo < 0 && barrierXTwo > -0.1 && birdXAxis == 1)) {
      timer?.cancel();
      gameOver = true;
      if (score > bestScore) {
        bestScore = score;
      }
    }
  }

  void updateScore() {
    if ((barrierXOne > -0.1 && barrierXOne < 0.1 && birdXAxis == 0) ||
        (barrierXTwo > -0.1 && barrierXTwo < 0.1 && birdXAxis == 1)) {
      setState(() {
        score++;
      });
    }
  }

  double get birdXAxis => screenWidth * birdSize / 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(birdXAxis, birdYAxis),
                    duration: const Duration(),
                    color: Colors.blue,
                    child: const MyBird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameHasStarted
                        ? const Text('')
                        : const Text(
                            'T A P   T O   P L A Y',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, 1.1),
                    duration: const Duration(),
                    child: const MyBarrier(
                        // size: barrierHeight,
                        ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, -1.1),
                    duration: const Duration(),
                    child: const MyBarrier(
                        // size: screenHeight - barrierHeight - 200.0,
                        ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, 1.1),
                    duration: const Duration(),
                    child: const MyBarrier(
                        // size: barrierHeight,
                        ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, -1.1),
                    duration: const Duration(),
                    child: const MyBarrier(
                        // size: screenHeight - barrierHeight - 150.0,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'SCORE',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '$score',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'BEST',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '$bestScore',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Icon(
        Icons.abc,
        size: 50,
      ),
    );
  }
}

// class MyBarrier extends StatelessWidget {
//   final double size;

//   const MyBarrier({super.key, required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100.0,
//       height: size,
//       decoration: BoxDecoration(
//         color: Colors.green,
//         border: Border.all(
//           width: 10.0,
//           color: Colors.green[800]!,
//         ),
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//     );
//   }
// }

// class MyBarrier extends StatelessWidget {
//   final double size;

//   const MyBarrier({super.key, required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         minWidth: 100.0,
//         maxWidth: 100.0,
//         minHeight: 0.0,
//         maxHeight: size,
//       ),
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           color: Colors.green,
//           border: Border.all(
//             width: 10.0,
//             color: Colors.green[800]!,
//           ),
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//       ),
//     );
//   }
// }
class MyBarrier extends StatelessWidget {
  const MyBarrier({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: MediaQuery.of(context).size.height *
          0.4, // Adjust the height as needed
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          width: 10,
          color: Colors.green[800]!,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
