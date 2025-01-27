import 'dart:convert';
import 'package:api_crud_using_provider/models/user_data_model.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'models/get_api_data_model.dart';
import 'package:http/http.dart' as http;



class GetApiProvider extends ChangeNotifier {
  List<GetApiDataModel> apiDataList = [];
  bool isLoading = false;
  bool isLoadingLogin = false;

  // UserDataModel..
  UserDataModel? userDataModel;

  getApiData() async {
    isLoading = true;
    var res =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    var resBody = jsonDecode(res.body);

    List<dynamic> data = resBody;

    apiDataList = data.map((json) => GetApiDataModel.fromJson(json)).toList();
    isLoading = false;
    print(resBody);
    notifyListeners();
  }


  // Login Post Api
  loginApi(String email, String password, BuildContext context) async {
    try {
      isLoadingLogin =true;
      notifyListeners();
      var res =
          await http.post(Uri.parse('https://reqres.in/api/login'),
          body: {"email": email, "password": password});

      if (res.statusCode == 200) {
        print('Login Successfully');
        var data = jsonDecode(res.body.toString());
        print(data);
        print(data["token"]);
        isLoadingLogin = false;
        notifyListeners();
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }
    } catch (e) {
      print(e.toString());
    }

  }


   getUserData(String userId) async {
     isLoading = true;
     var res =
         await http.get(Uri.parse("https://reqres.in/api/users/$userId"));

     var resBody = jsonDecode(res.body);
     print(resBody);
     userDataModel = resBody;
     isLoading = false;
     print(userDataModel);

     notifyListeners();

   }


}
