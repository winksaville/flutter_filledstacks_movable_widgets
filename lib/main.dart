import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() => runApp(TheApp());

// The application object
class TheApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movable Widgets Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

// The list of movableItems is the State for HomeView.
// MovableItems list can change during HomeView life time,
// i.e. each time the FloatingActionButton is pressed a
// MovableStackItem is created.
class _HomeViewState extends State<HomeView> {
  List<Widget> _movableItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() => _movableItems.add(MovableStackItem()));
          },
        ),
        body: Stack(
          children: _movableItems,
        ));
  }
}

// A MovableStackItem is a "Container" that can be moved.
class MovableStackItem extends StatefulWidget {
  @override
  _MovableStackItemState createState() =>
      _MovableStackItemState(color: RandomColor().randomColor());
}

// Creates the Container (a square 150x150) which its position can
// change by dragging after it's created.
class _MovableStackItemState extends State<MovableStackItem> {
  double _xPosition = 0;
  double _yPosition = 0;
  final Color color;

  _MovableStackItemState({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _yPosition,
      left: _xPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            _xPosition += tapInfo.delta.dx;
            _yPosition += tapInfo.delta.dy;
          });
        },
        child: Container(
          width: 150,
          height: 150,
          color: color,
        ),
      ),
    );
  }
}
