import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Timer _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          _milliseconds += 10;
        });
      });
      _isRunning = true;
    }
  }

  void _pauseTimer() {
    if (_isRunning) {
      _timer.cancel();
      _isRunning = false;
    }
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int milliseconds) {
    int minutes = milliseconds ~/ 60000;
    int seconds = (milliseconds % 60000) ~/ 1000;
    int milli = (milliseconds % 1000) ~/ 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milli.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(_milliseconds),
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _startTimer,
                child: Text('Start'),
              ),
              ElevatedButton(
                onPressed: _pauseTimer,
                child: Text('Pause'),
              ),
              ElevatedButton(
                onPressed: _resetTimer,
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }
}