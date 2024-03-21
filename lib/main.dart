import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 6, 71, 124),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _squares = List.generate(9, (index) => ' ');
  bool _xIsNext = true;
  String _result = '';

  void _getResult() {
    var winners = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var winner in winners) {
      var squares = winner.map((index) => _squares[index]).toList();
      if (squares.every((square) => square == 'X')) {
        setState(() {
          _result = 'X has won!';
        });
        return;
      } else if (squares.every((square) => square == 'O')) {
        setState(() {
          _result = 'O has won!';
        });
        return;
      }
    }
    if (!_squares.contains(' ')) {
      setState(() {
        _result = 'It\'s a draw!';
      });
    }
  }

  void _onTap(int index) {
    if (_squares[index] == ' ' && _result.isEmpty) {
      setState(() {
        _squares[index] = _xIsNext ? 'X' : 'O';
        _xIsNext = !_xIsNext;
        _getResult();
      });
    }
  }

  void _resetGame() {
    setState(() {
      _squares = List.generate(9, (index) => ' ');
      _xIsNext = true;
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color.fromARGB(255, 6, 71, 124), // Set app bar color
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20), // Add some space between AppBar and "Tic Tac Toe"
          const Text(
            'Tic Tac Toe',
            style: TextStyle(
              fontSize: 36, // Increase font size
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Pacifico', // Use a funky font
            ),
          ),
          const SizedBox(height: 40), // Add more space between "Tic Tac Toe" and the grid
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(9, (index) {
                  return GestureDetector(
                    onTap: () => _onTap(index),
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow, // Set the box color to white
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15.0), // Add rounded corners
                      ),
                      child: Center(
                        child: Text(
                          _squares[index],
                          style: const TextStyle(
                            fontSize: 40, // Increase font size of X and O
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500), // Animation duration
            height: _result.isNotEmpty ? 50 : 0, // Only show if there's a result
            child: Center(
              child: Text(
                _result,
                style: const TextStyle(
                  fontSize: 40, // Increase font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Change text color to black
                ),
              ),
            ),
          ),
          const SizedBox(height: 20), // Add space between result and reset button
          ElevatedButton(
            onPressed: _resetGame,
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
              shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              elevation: MaterialStateProperty.resolveWith((states) => 10),
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
            ),
            child: const Text(
              'Reset Game',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20), // Add more space below the reset button
        ],
      ),
    );
  }
}
