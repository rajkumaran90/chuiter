import 'package:flutter/foundation.dart';
import 'package:twitter/enums/view_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  String errorMessage = '';
  ViewState get state => _state;
  bool get hasError => _state == ViewState.Error;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    _state = ViewState.Error;
    notifyListeners();
  }
}
