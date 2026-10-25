import 'package:flutter/material.dart';
import 'package:onstagram/services/api.dart';

class BaseProvider with ChangeNotifier {
  Api api = Api();

  bool busy = false;
  bool busyMore = false;
  bool failed = false;
  bool pagenating = false;


  void setBusy(bool value) {
    busy = value;
    notifyListeners();
  }

  void setBusyMore(bool value) {
    busyMore = value;
    notifyListeners();
  }

  void setFailed(bool value) {
    failed = value;
    notifyListeners();
  }

  void setPagenating(bool value) {
    pagenating = value;
    notifyListeners();
  }
}
