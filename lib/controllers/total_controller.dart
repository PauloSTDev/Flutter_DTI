import 'package:flutter/cupertino.dart';

class TotalController extends ChangeNotifier{

  int _total = 0;
  int _quantity = 0;

  int get total => _total;
  int get quantity => _quantity;

  totalNumber(int increment) {
    _total = _total + increment;
    notifyListeners();
  }

  totalQuantity(int quantidade) {
    _quantity = _quantity + quantidade;
    notifyListeners();
  }
  zerarTotal(int diminuir) {
    _total = total - diminuir;
    notifyListeners();
  }

}