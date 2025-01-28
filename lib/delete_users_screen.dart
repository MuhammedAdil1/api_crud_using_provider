import 'package:api_crud_using_provider/providers/apis_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteUsersScreen extends StatefulWidget {
  const DeleteUsersScreen({super.key});

  @override
  State<DeleteUsersScreen> createState() => _DeleteUsersScreenState();
}

class _DeleteUsersScreenState extends State<DeleteUsersScreen> {
  @override
  void initState() {
    super.initState();
    GetApiProvider apiProvider =
    Provider.of<GetApiProvider>(context, listen: false);

    apiProvider.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    GetApiProvider apiProvider = Provider.of<GetApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Get All Users',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 10,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: apiProvider.getAllUserDataISLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: apiProvider.getAllUsersList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    apiProvider.getAllUsersList[index].avatar!,
                  ),
                  radius: 25,
                ),
                title: Text(
                  apiProvider.getAllUsersList[index].firstName!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  apiProvider.getAllUsersList[index].email!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    print(apiProvider.getAllUsersList[index].id!.toString());
                    apiProvider.deleteUser(
                        apiProvider.getAllUsersList[index].id!.toString(),
                        index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
