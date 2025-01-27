import 'package:api_crud_using_provider/apis_provider.dart';
import 'package:api_crud_using_provider/models/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUserDataScreen extends StatefulWidget {
  const UpdateUserDataScreen({super.key});

  @override
  State<UpdateUserDataScreen> createState() => _UpdateUserDataScreenState();
}

class _UpdateUserDataScreenState extends State<UpdateUserDataScreen> {


  @override
  void initState() {
     super.initState();
     GetApiProvider apiProvider =
     Provider.of <GetApiProvider> (context, listen: false);
     apiProvider.getUserData("2");
  }
  @override
  Widget build(BuildContext context) {

    GetApiProvider apiProvider = Provider.of <GetApiProvider> (context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: apiProvider.isLoading ==  true?  Center(
        child: CircularProgressIndicator(),
      ):
      Column(
        children: [
          Image.network(apiProvider.userDataModel!.data!.avatar!),
          SizedBox(height: 20),
          Row(
            children: [
              Text("Name : ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20),
              Text(apiProvider.userDataModel!.data!.firstName!)
            ],
          )
        ],
      ),
    );
  }
}
