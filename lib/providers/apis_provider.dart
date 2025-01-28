import 'dart:convert';
import 'package:api_crud_using_provider/models/get_all_users_model.dart';
import 'package:api_crud_using_provider/models/user_data_model.dart';
import 'package:flutter/material.dart';
import '../home_screen.dart';
import '../models/get_api_data_model.dart';
import 'package:http/http.dart' as http;



class GetApiProvider extends ChangeNotifier {

  List<GetApiDataModel> apiDataList = [];


  bool isLoading = false;
  bool isLoadingLogin = false;
  // UserDataModel..
  UserDataModel? userDataModel;
  bool isLoadingUpdateProfile = false;


  List <GetAllUsersModel> getAllUsersList = [];
  bool getAllUserDataISLoading = false;



  // GET method..
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


  // Login :  Post method..
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


   // GET method..
   getUserData(String userId) async {
     isLoading = true;
     var res =
         await http.get(Uri.parse("https://reqres.in/api/users/$userId"));

     var resBody = jsonDecode(res.body);
     print(resBody);
                     // model.    fromJson
     userDataModel = UserDataModel.fromJson(resBody);
     isLoading = false;
     print(userDataModel);

     notifyListeners();
   }



   // PUT method..
  Future<void> updateUserProfile(String userId, Map<String, String> data) async {
    try {
      isLoadingUpdateProfile = true;
      notifyListeners();

      // Send PUT request to update user profile
      final res = await http.put(
        Uri.parse("https://reqres.in/api/users/$userId"),
        body: data,
      );

      if (res.statusCode == 200) {
        print("Updated successfully");

        // Parse the response body
        final resBody = jsonDecode(res.body);
        print(resBody);

        // Update local user data model
        userDataModel?.data?.firstName = resBody["first_name"];
        userDataModel?.data?.lastName = resBody["last_name"];
        userDataModel?.data?.email = resBody["email"];
      } else {
        print("Failed to update. Status code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      // Reset loading state and notify listeners
      isLoadingUpdateProfile = false;
      notifyListeners();
    }
  }



 getAllUsers () async {
   getAllUserDataISLoading= true;

    var res =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    var resBody = jsonDecode(res.body);

    List <dynamic> data = resBody["data"];
    getAllUsersList = data.map((json)=>GetAllUsersModel.fromJson(json)).toList();

    getAllUserDataISLoading = false;
    notifyListeners();
 }




 deleteUser (String userId, int index) async {

     var res =
         await http.delete(Uri.parse("https://reqres.in/api/users/$userId"));

     if(res.statusCode == 204) {
       print(res);
      getAllUsersList.removeAt(index );
      notifyListeners();
     }
 }

}
