part of 'snake_game_screen.dart';

const int rows = 20;
const int squares = 400;

// List<int> snakeInitialPosition = [0];
int initialScore = 0;

enum Direction { up, down, left, right }

class SnakeBody extends StatelessWidget {
  const SnakeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      child: Container(
        margin: const EdgeInsets.all(1),
        color: Colors.grey.shade100,
      ),
    );
  }
}

class BlankBox extends StatelessWidget {
  const BlankBox({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      child: Container(
        margin: const EdgeInsets.all(1),
        color: Colors.grey.shade800,
        // child: Center(
        //   child: Text(
        //     '$index',
        //     style: Theme.of(context).textTheme.bodyLarge,
        //   ),
        // ),
      ),
    );
  }
}

class FoodBox extends StatelessWidget {
  const FoodBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      child: Container(
        margin: const EdgeInsets.all(1),
        color: Colors.green,
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  const BoxWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: child,
      ),
    );
  }
}
