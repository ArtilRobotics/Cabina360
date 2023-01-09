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
        route: 'configcamara',
        name: 'Setting_Camara',
        screen: const ConfiguracionCamaraScreen(),
        icon: Icons.settings_input_component_rounded),
    MenuOption(
        route: 'galeria',
        name: 'Galeria',
        screen: const GaleriaScreen(),
        icon: Icons.photo_library_rounded),
    MenuOption(
        route: 'camara',
        name: 'Camara',
        screen: const CamaraScreen(),
        icon: Icons.camera_alt_rounded),
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
    MenuOption(
        route: 'camaraapi',
        name: 'Camara_API',
        screen: const CamaraAPIScreen(),
        icon: Icons.camera_rear),
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
      builder: (context) => const GaleriaScreen(),
    );
  }
}
