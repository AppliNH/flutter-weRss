import 'package:flutter/material.dart';

class ScrollControl with ChangeNotifier {

  bool _isFABvisible = true;

  bool get isFABvisible {
    return _isFABvisible;
  }

  controlButtonVisib(bool v) {
    _isFABvisible = v;
    notifyListeners();
  }

}