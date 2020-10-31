import 'package:flutter/material.dart';

class AdminMode extends ChangeNotifier{
  bool mode = false;
  modeChange(bool value){
    mode = value;
    notifyListeners();
  }

}