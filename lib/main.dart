import 'package:contact_gesion/src/auth/auth_ccontroller.dart';
import 'package:contact_gesion/src/auth/auth_services.dart';
import 'package:contact_gesion/src/auth/auth_view.dart';
import 'package:contact_gesion/src/contact/contact_controller.dart';
import 'package:contact_gesion/src/contact/contact_view.dart';
import 'package:contact_gesion/src/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  late final AuthController _authController;
  late final ContactController _contactController;

  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authController = AuthController(_authService);
    _contactController = ContactController();

    _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => AuthScreen(_authController),
        ),
        GoRoute(
          path: '/welcome',
          builder: (context, state) => WelcomeScreen(
            name: state.extra as String,
            authController: _authController,
          ),
        ),
        GoRoute(
          path: '/contacts',
          builder: (context, state) => ContactHomePage(
            controller: _contactController,
          ),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) async {
        final storedUser = await _authController.getStoredUser();
        if (storedUser != null && state.location == '/') {
          return '/welcome';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
