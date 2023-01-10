import 'dart:async';

//import 'package:fl_components/models/models.dart';
import 'package:cabina360_app/models/menu_option.dart';
import 'package:cabina360_app/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'home';
  static final menuOptions = <MenuOption>[
    // MenuOption(
    //     route: 'home',
    //     name: 'Home Screen',
    //     screen: const HomeScreen(),
    //     icon: Icons.access_alarm_outlined),
    MenuOption(
        route: 'rccontrol',
        name: 'RC',
        screen: const RCScreen(),
        icon: Icons.settings_remote_rounded),

    MenuOption(
        route: 'configrc',
        name: 'Setting_RC',
        screen: const ConfiguracionRCScreen(),
        icon: Icons.settings_sharp),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes
        .addAll({'home': (BuildContext context) => const HomeScreen1Screen()});

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  //static Map<String, Widget Function(BuildContext)> routes = {
  //  'home': (BuildContext context) => const HomeScreen(),
  //  'listview1': (BuildContext context) => const Listview1Screen(),
  //  'listview2': (BuildContext context) => const Listview2Screen(),
  //  'alert': (BuildContext context) => const AlertScreen(),
  //  'card': (BuildContext context) => const CardScreen(),
  //};

  //Esta funcion se utiliza para generar rutas dinamicas
  // para la funcion Navigator, en caso de que la escena
  // no se encuentre ruteada
  //en caso de que 'escena' no la detecte como ruta
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      //builder: (context) => const AlertScreen(),
      builder: (context) => const RCScreen(),
    );
  }
}
