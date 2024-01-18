import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:icare/screens/appointments_screen.dart';
import 'package:icare/screens/book_appointment_screen.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icare/screens/login_screen.dart';
import 'package:icare/screens/profile_screen.dart';
import 'package:icare/screens/register_screen.dart';
import 'package:icare/utils/theme/constants.dart';
import 'package:icare/utils/theme/theme.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale = const Locale('en', ''); // Initial locale

  void _changeLocale(Locale newLocale) {
    setState(() {
      _currentLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nethrakshana',
      localizationsDelegates: [
        AppLocalizations.delegate,

      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ta', ''),
      ],
      locale: _currentLocale, // Use the current locale
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/login',
      routes: {

        '/login': (context) => LoginScreen(), // Root route
        '/register': (context) => RegisterScreen(), // Root route
        '/getUIN': (context) => LoginScreen(), // Root route

        '/home': (context) => NavigationMenu(
          changeLocale: _changeLocale, // Pass the function to NavigationMenu
        ),
      },
    );
  }
}

class NavigationMenu extends StatefulWidget {
  final Function(Locale) changeLocale;

  const NavigationMenu({super.key, required this.changeLocale});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}


class _NavigationMenuState extends State<NavigationMenu> {

  int selectedPageIndex = 0;
  late List<NavigationDestination> _destinations;

  @override
  Widget build(BuildContext context) {
    NavigationDestination Destination(Icon icon, Icon selected, String label){
      return NavigationDestination(icon: icon, selectedIcon: selected, label: label);
    }
    _destinations = [
      Destination(const Icon(Icons.home),const Icon(Icons.home_outlined), AppLocalizations.of(context)!.homeIcon),
      Destination(const Icon(Icons.person),const Icon(Icons.person_outline), "Hello"),
      Destination(const Icon(Icons.person),const Icon(Icons.person_outline), "Hello"),
      Destination(const Icon(Icons.person),const Icon(Icons.person_outline), "Hello"),
    ];
    List<Widget> _screens = [
      HomeScreen(),
      BookAppointmentScreen(),
      AppointmentsScreen(),
      UserProfileScreen()
    ];

    AppBar appBar =  AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        elevation: 80,
        actions:  [IconButton(
                onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Language'),
            content: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                ListTile(
                  title: Text('English'),
                  onTap: () {
                    widget.changeLocale(const Locale('en', ''));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('தமிழ்'),
                  onTap: () {
                    widget.changeLocale(const Locale('ta', ''));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    },
    icon: Icon(Icons.translate_outlined),
    ),]
      );


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Constants.navbarheight),
        child: appBar,
      ),
      body: _screens[selectedPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        destinations: _destinations,
      ),
    );


  }


}


