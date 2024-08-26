import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Dark theme
      ),
      home: const StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    setState(() {
      _stopwatch.start();
    });
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _stopStopwatch() {
    setState(() {
      _stopwatch.stop();
    });
    _timer.cancel();
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
    });
  }

  String _formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    var millisecondsStr = (milliseconds % 1000).toString().padLeft(3, '0');
    return "$hours:$minutes:$seconds.$millisecondsStr";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                style: TextStyle(
                    color: Color.fromARGB(255, 187, 187, 187),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                "STOP WATCH"),
            // const SizedBox(
            //   height: 50,
            // ),
            Text(
              _formatTime(_stopwatch.elapsedMilliseconds),
              style: const TextStyle(
                  color: Color.fromARGB(255, 170, 202, 199),
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 10.0),
                      backgroundColor: _stopwatch.isRunning
                          ? const Color.fromARGB(255, 216, 31, 18)
                          : const Color.fromARGB(255, 72, 62, 62),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed:
                        _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                    child: Text(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.8,
                            color: Color.fromARGB(255, 187, 187, 187),
                            fontSize: 20),
                        _stopwatch.isRunning ? ' STOP ' : 'START'),
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 10.0),
                      backgroundColor: const Color.fromARGB(255, 72, 62, 62),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: _resetStopwatch,
                    child: const Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            color: Color.fromARGB(255, 187, 187, 187),
                            fontSize: 20),
                        "RESET"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
