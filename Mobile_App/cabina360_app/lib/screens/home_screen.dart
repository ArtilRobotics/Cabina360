import 'package:cabina360_app/router/app_router.dart';
import 'package:cabina360_app/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen1Screen extends StatefulWidget {
  const HomeScreen1Screen({Key? key}) : super(key: key);

  @override
  State<HomeScreen1Screen> createState() => _HomeScreen1ScreenState();
}

class _HomeScreen1ScreenState extends State<HomeScreen1Screen> {
  int _paguinaActual = 2;

  final List<Widget> _paguinas = [
    const ConfiguracionCamaraScreen(),
    const GaleriaScreen(),
    const CamaraScreen(),
    const RCScreen(),
    const ConfiguracionRCScreen(),
  ];

  final menuOptions = AppRoutes.menuOptions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _paguinas[_paguinaActual],
        bottomNavigationBar: customBottomNavigationBar());
  }

  BottomNavigationBar customBottomNavigationBar() {
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.pink,
        backgroundColor: const Color.fromRGBO(55, 57, 84, 1),
        unselectedItemColor: const Color.fromRGBO(116, 117, 152, 1),
        onTap: (index) {
          setState(() {
            _paguinaActual = index;
          });
        },
        currentIndex: _paguinaActual,
        items: [
          BottomNavigationBarItem(
              icon: Icon(menuOptions[0].icon), label: menuOptions[0].name),
          BottomNavigationBarItem(
              icon: Icon(menuOptions[1].icon), label: menuOptions[1].name),
          BottomNavigationBarItem(
              icon: Icon(menuOptions[2].icon), label: menuOptions[2].name),
          BottomNavigationBarItem(
              icon: Icon(menuOptions[3].icon), label: menuOptions[3].name),
          BottomNavigationBarItem(
              icon: Icon(menuOptions[4].icon), label: menuOptions[4].name),
        ]);
  }
}
