import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = 'X';
    _gameOver = false;
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] == '' && !_gameOver) {
      setState(() {
        _board[row][col] = _currentPlayer;
        _checkGameStatus();
        if (!_gameOver) {
          _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
          if (_currentPlayer == 'O') {
            Timer(const Duration(seconds: 1), _makeComputerMove);
          }
        }
      });
    }
  }

  void _checkGameStatus() {
    // Check rows
    for (var i = 0; i < 3; i++) {
      if (_board[i][0] != '' &&
          _board[i][0] == _board[i][1] &&
          _board[i][0] == _board[i][2]) {
        _gameOver = true;
        break;
      }
    }

    // Check columns
    for (var i = 0; i < 3; i++) {
      if (_board[0][i] != '' &&
          _board[0][i] == _board[1][i] &&
          _board[0][i] == _board[2][i]) {
        _gameOver = true;
        break;
      }
    }

    // Check diagonals
    if (_board[0][0] != '' &&
        _board[0][0] == _board[1][1] &&
        _board[0][0] == _board[2][2]) {
      _gameOver = true;
    }

    if (_board[0][2] != '' &&
        _board[0][2] == _board[1][1] &&
        _board[0][2] == _board[2][0]) {
      _gameOver = true;
    }

    if (_gameOver) {
      _showRestartDialog(context, 'Player $_currentPlayer won!');
    } else if (_board.every((row) => row.every((cell) => cell != ''))) {
      _showRestartDialog(context, "It's a draw!");
    }
  }

  void _makeComputerMove() {
    // Get all available empty cells
    final emptyCells = <int>[];
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          emptyCells.add(i * 3 + j);
        }
      }
    }

    // Randomly select an empty cell
    final random = Random();
    final randomIndex = random.nextInt(emptyCells.length);
    final cellIndex = emptyCells[randomIndex];

    // Convert cell index to row and column
    final row = cellIndex ~/ 3;
    final col = cellIndex % 3;

    // Make the computer move
    _makeMove(row, col);
  }

  void _showRestartDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Restart'),
              onPressed: () {
                _initializeBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).whenComplete(_initializeBoard);
  }

  Widget _buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => _makeMove(row, col),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Text(
            _board[row][col],
            style: const TextStyle(fontSize: 48),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBoard() {
    final rows = <Widget>[];
    for (var i = 0; i < 3; i++) {
      final row = <Widget>[];
      for (var j = 0; j < 3; j++) {
        row.add(_buildCell(i, j));
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row,
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Player: $_currentPlayer',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Column(children: _buildBoard()),
            ],
          ),
        ),
      ),
    );
  }
}
