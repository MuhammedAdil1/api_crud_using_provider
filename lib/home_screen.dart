import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'apis_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    GetApiProvider getApiProvider =
    Provider.of<GetApiProvider>(context, listen: false);
    getApiProvider.getApiData();
  }

  @override
  Widget build(BuildContext context) {
    GetApiProvider getApiProvider = Provider.of<GetApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'API Data',
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
            colors: [Colors.blueGrey, Colors.indigo], // Softer gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: getApiProvider.isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: getApiProvider.apiDataList.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 15),
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.indigo,
                  child: Text(
                    getApiProvider.apiDataList[index].id.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  getApiProvider.apiDataList[index].title.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    getApiProvider.apiDataList[index].body.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
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
