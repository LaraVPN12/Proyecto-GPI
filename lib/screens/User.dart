import 'package:flutter/material.dart';
import 'package:proyecto_visitas/screens/AddRegister.dart';
import 'package:proyecto_visitas/screens/Historial.dart';
import 'package:proyecto_visitas/screens/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  SharedPreferences? preferences;
  static String email = "";

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  loadPreferences() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences!.getString("email")!;
    });
  }

  int index = 0;
  final screens = [
    const AddRegister(),
    const Historial(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.greenAccent.shade100,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.greenAccent.shade200,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home_rounded),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: 'Historial de Visitas',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.account_circle),
              icon: Icon(Icons.account_circle_outlined),
              label: 'Perfil',
            )
          ],
        ),
      ),
    );
  }
}
