import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeProvider extends ChangeNotifier {
  bool dark = false;
  var box = Hive.box("theme");

  void firstCreate(){
    dark = false;
  }

  void loadTheme(){
    dark = box.get("data");
  }

  void changeTheme()async{
    if(dark){
      dark = false;
    }else{
      dark = true;
    }
    await box.put("data", dark);
    notifyListeners();
  }
}