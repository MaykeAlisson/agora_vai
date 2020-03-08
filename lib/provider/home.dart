import 'package:agora_vai/db/db_provider.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  DBProvider db;

  bool _jaEhUsuario;
  String _userName;

  bool get jaEhUsuario {
    return _jaEhUsuario != null;
  }

  String get getUserName {
    return _userName;
  }

//  Future<void> buscaTodosDados() async {
//    try{
//      bool doesFileExits = await storage.fileExits();
//      if(doesFileExits){
//        String jsonData = await storage.getData();
//        Map<String,dynamic> data = jsonDecode(jsonData);
//
//        //assigning data
//        _userName = data['userName'];
//        List<String> tempTypes = [];
//        data['types'].forEach((dynamic type){
//          tempTypes.add(type.toString());
//        });
//        _types = tempTypes;
//        Map<String,TasksProvider> tempList = {};
//        _types.forEach((type){
//          //print("type:$type");
//          Map<String,dynamic> _eachType = data['tasks'][type];
//          TasksProvider _newTasksProvider = TasksProvider(type,_eachType);
//          tempList.addAll({type:_newTasksProvider});
//        });
//        _taskProviders = tempList;
//      }
//      //print("All initializatiion done");
//      notifyListeners();
//    }catch(e){
//      //print("Initializatiion failed");
//      //print(e);
//    }
//  }

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

//  Future<bool> verificaSeExisteDados() async {
//    bool oUsuarioExiste = await db.fileExits();
//    if(doesUserExists==false){
//      return false;
//    }
//    _isNewUser = true;
//    notifyListeners();
//    return true;
//  }
}