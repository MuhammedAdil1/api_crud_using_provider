import 'package:api_crud_using_provider/delete_users_screen.dart';
import 'package:api_crud_using_provider/home_screen.dart';
import 'package:api_crud_using_provider/update_user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/apis_provider.dart';
import 'login_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetApiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'API Integration Using Provider',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
