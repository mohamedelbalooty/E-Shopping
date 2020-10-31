import 'package:flutter/material.dart';

class ModalHud extends ChangeNotifier{
  bool isLoading = false;
  isLoadingChange(bool value){
    isLoading = value;
    notifyListeners();
  }
}