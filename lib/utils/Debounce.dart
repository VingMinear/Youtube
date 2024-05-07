import 'dart:async';
import 'package:flutter/material.dart';

class Debounce {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;
  Debounce({
    required this.milliseconds,
  });
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() => _timer?.cancel();
}
