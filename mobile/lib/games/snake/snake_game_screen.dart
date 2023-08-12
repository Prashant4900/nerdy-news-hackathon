import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

part 'widget.dart';

class MySnakeGameScreen extends StatefulWidget {
  const MySnakeGameScreen({super.key});

  @override
  State<MySnakeGameScreen> createState() => _MyGameScreenState();
}

class _MyGameScreenState extends State<MySnakeGameScreen> {
  // User current score
  int currentScore = initialScore;

  // Snake position
  List<int> snakePosition = [0, 1];

  // Food position
  int foodPosition = Random().nextInt(squares);

  // Current direction
  Direction currentDirection = Direction.right;

  // Start Game
  void startGame() {
    resetGame();
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        moveSnake();

        if (isGameOver()) {
          timer.cancel();
          _showGameOverDialog();
        }
      });
    });
  }

  // Reset Game
  void resetGame() {
    setState(() {
      currentScore = initialScore;
      snakePosition = [0, 1];
      foodPosition = Random().nextInt(squares);
      currentDirection = Direction.right;
    });
  }

  // Show Game Over Dialog
  void _showGameOverDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Your score: $currentScore'),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.of(context).pop();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void moveSnake() {
    // Add snake head
    switch (currentDirection) {
      case Direction.up:
        if (snakePosition.last < rows) {
          snakePosition.add(snakePosition.last + squares - rows);
        } else {
          snakePosition.add(snakePosition.last - rows);
        }
      case Direction.down:
        if (snakePosition.last > squares) {
          snakePosition.add(snakePosition.last - squares);
        } else {
          snakePosition.add(snakePosition.last + rows);
        }
      case Direction.left:
        if (snakePosition.last % rows == 0) {
          snakePosition.add(snakePosition.last + rows - 1);
        } else {
          snakePosition.add(snakePosition.last - 1);
        }
      case Direction.right:
        if (snakePosition.last % rows == rows - 1) {
          snakePosition.add(snakePosition.last - rows + 1);
        } else {
          snakePosition.add(snakePosition.last + 1);
        }
    }

    // Check if snake eats food
    if (snakePosition.last == foodPosition) {
      // Increase score
      currentScore++;

      snakePosition.add(snakePosition.last);

      // Generate new food
      generateNewFood();
    }

    // Remove snake tail
    snakePosition.removeAt(0);
  }

  void generateNewFood() {
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(squares);
    }
  }

  // Game Over
  bool isGameOver() {
    // Snake Body without head
    final snakeBody = snakePosition.sublist(0, snakePosition.length - 2);

    // Check if snake hits itself
    if (snakeBody.contains(snakePosition.last)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Snake Game',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: Text(
                      'Score: $currentScore',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0 &&
                      currentDirection != Direction.up) {
                    // Move down
                    currentDirection = Direction.down;
                  }
                  if (details.delta.dy < 0 &&
                      currentDirection != Direction.down) {
                    // Move up
                    currentDirection = Direction.up;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0 &&
                      currentDirection != Direction.left) {
                    // Move right
                    currentDirection = Direction.right;
                  }
                  if (details.delta.dx < 0 &&
                      currentDirection != Direction.right) {
                    // Move left
                    currentDirection = Direction.left;
                  }
                },
                child: GridView.builder(
                  itemCount: squares,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rows,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (snakePosition.contains(index)) {
                      return const SnakeBody();
                    }
                    if (index == foodPosition) {
                      return const FoodBox();
                    }
                    return BlankBox(index: index);
                  },
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: startGame,
                  child: const Text('Start Game'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
