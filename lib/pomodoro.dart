import 'dart:async';
import 'package:flutter/material.dart';
import 'package:virtual_study_buddy/colors.dart';

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int _duration = 25 * 60;
  bool _isRunning = false;
  String _message = 'Ready to start';

  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _formatDuration(_duration),
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          _message,
          style: TextStyle(fontSize: 24, color: Colors.grey),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_isRunning) {
              stopTimer();
            } else {
              startTimer(_duration);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: _isRunning ? AppColors.primary : AppColors.secondary,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: Text(
            _isRunning ? 'Stop' : 'Start',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                startTimer(5 * 60);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'Short Break',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                startTimer(15 * 60);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'Long Break',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: resetTimer,
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: Text(
            'Reset',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void startTimer(int duration) {
    _isRunning = true;
    _message = 'Work in progress...';
    _duration = duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration > 0) {
        setState(() {
          _duration -= 1;
        });
      } else {
        stopTimer();
        _message = 'Break is over!';
      }
    });
  }

  void stopTimer() {
    _isRunning = false;
    _timer.cancel();
    _message = 'Timer paused';
  }

  void resetTimer() {
    _isRunning = false;
    _timer.cancel();
    setState(() {
      _duration = 25 * 60;
      _message = 'Ready to start';
    });
  }
}
