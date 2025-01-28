import 'package:api_crud_using_provider/providers/apis_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    GetApiProvider apiProvider = Provider.of <GetApiProvider> (context);

    return  Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                hintText: "First Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                hintText: "Last Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email", border: OutlineInputBorder()),
            ),
            SizedBox(height: 50,),

            ElevatedButton(
                onPressed: () async {
                  await apiProvider.updateUserProfile( "2", {
                "email": emailController.text ,
                "first_name": firstNameController.text,
                "last_name": lastNameController.text,

              } );
            },
                child: apiProvider.isLoadingUpdateProfile == true?
                Center(child: CircularProgressIndicator(),
                )
                    :Text("Update"))
          ],
        ),
      ),
    );
  }
}
