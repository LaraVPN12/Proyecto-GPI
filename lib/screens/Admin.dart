import 'package:flutter/material.dart';
import 'package:proyecto_visitas/screens/AddMember.dart';
import 'package:proyecto_visitas/screens/AdminProfile.dart';
import 'package:proyecto_visitas/screens/Stadistics.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int index = 0;
  final screens = [
    const Stadistics(),
    const AddMember(),
    const AdminProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.amber[100],
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: const Color(0xff152534),
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home_rounded,
                color: Color(0xff152534),
              ),
              icon: Icon(
                Icons.home_outlined,
                color: Color(0xff55CADB),
              ),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.account_circle,
                color: Color(0xff152534),
              ),
              icon: Icon(
                Icons.account_circle_outlined,
                color: Color(0xff55CADB),
              ),
              label: 'Agregar Miembro',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.account_circle,
                color: Color(0xff152534),
              ),
              icon: Icon(
                Icons.account_circle_outlined,
                color: Color(0xff55CADB),
              ),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
