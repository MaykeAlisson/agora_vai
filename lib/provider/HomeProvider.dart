import 'package:agora_vai/db/DbHelper.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  // Data Base
  var _db = DBHelper();

  bool _jaEhUsuario;
  String _userName;
  int _qtdLancamentos;

  bool get jaEhUsuario {

    verificaSeExisteDados();

    return _jaEhUsuario != null;
  }

  String get getUserName {
    return _userName;
  }

  int get getQtdLancamento{
    return _qtdLancamentos;
  }

  Future<bool> verificaSeExisteDados() async {
    var usuario = await _db.existeUsuario();
    if (usuario == false) {
      return false;
    }
    _jaEhUsuario = true;
    notifyListeners();
    return true;
  }

//  Future<bool> createNewUserData(String userName) async {
//    Map<String,dynamic> newUserData = {
//      "userName" : userName,
//      "types" : ["common"],
//      "tasks" : {
//        "common" : {
//          DateTime.now().toString() : Task(id: DateTime.now().toString(),type: "common",name: "Common Task 1",isDone: false)
//        }
//      }
//    };
//    try{
//      File success = await storage.createNewUserFile(newUserData);
//      if(success!=null){
//        //print("New User Created");
//        _isNewUser = true;
//        notifyListeners();
//        return true;
//      }
//    }catch(e){
//      //print(e);
//      //print("New User Creation failed");
//      return false;
//    }
//    return false;
//  }

}
