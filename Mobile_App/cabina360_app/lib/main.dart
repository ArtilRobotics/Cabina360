import 'package:cabina360_app/router/app_router.dart';
import 'package:flutter/material.dart';

//main creado con mateapp
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:
            false, //para quitar el nombre debug en pantalla
        title: 'Material App',
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.getAppRoutes());
    //onGenerateRoute: AppRoutes.onGenerateRoute,
    //theme: AppTheme.lightTheme);
  }
}
