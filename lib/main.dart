import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:icare/screens/appointments_screen.dart';
import 'package:icare/screens/book_appointment_screen.dart';
import 'package:icare/screens/eye_condition_screen.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icare/screens/login_screen.dart';
import 'package:icare/screens/overview_screen.dart';
import 'package:icare/screens/payment_screen.dart';
import 'package:icare/screens/profile_screen.dart';
import 'package:icare/screens/register_screen.dart';
import 'package:icare/screens/reports_screen.dart';
import 'package:icare/utils/theme/constants.dart';
import 'package:icare/utils/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      title: "Nethrakshana",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate,


      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ta', ''),
      ],
      locale: _currentLocale, // Use the current locale
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => EasySplashScreen(
        logo: Image.network(
        'https://th.bing.com/th/id/OIP.ulAWCOZSCkmx79K2ucfVeQHaEY?rs=1&pid=ImgDetMain'),
        title: Text(
        "Aravind Eye Care System",

        style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: Colors.grey.shade400,
        showLoader: true,
        loadingText: Text("Loading..."),
        navigator: LoginScreen(),
        durationInSeconds: 5,
        ),
        '/login': (context) => LoginScreen(), // Root route
        '/register': (context) => RegisterScreen(), // Root route
        '/getUIN': (context) => LoginScreen(), // Root route
        '/upi_payment': (context) => UpiPaymentScreen(),
        '/book': (context) => BookAppointmentScreen(),
        '/overview': (context) => OphthalmologyBlogScreen(),
        '/eyeconditions': (context) => EyeBlogScreen(),
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
      Destination(const Icon(Icons.receipt),const Icon(Icons.receipt_outlined), AppLocalizations.of(context)!.reportIcon),
      Destination(const Icon(Icons.calendar_today),const Icon(Icons.calendar_today_outlined), AppLocalizations.of(context)!.appointmentIcon),
      Destination(const Icon(Icons.person),const Icon(Icons.person_outline), AppLocalizations.of(context)!.profileIcon),
    ];
    List<Widget> _screens = [
      HomeScreen(),
      PrescriptionScreen(),
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
    icon: Icon(Icons.translate_outlined,color: Colors.white,),
    ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white,),
            onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear(); // Clear all shared preferences

          Navigator.pushReplacementNamed(context, '/login');
          },
          ),
        ]
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


