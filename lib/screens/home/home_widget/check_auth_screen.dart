import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';
import '../../login/login_screen.dart';
import '../home_tab.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
  //  authService.verifyLogin(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: authService.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.data == '') {
                Future.microtask(() {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const LoginScreen(),
                          transitionDuration: const Duration(seconds: 0)));
                });
              } else if (snapshot.data != null && snapshot.data != '') {
                Future.microtask(() async {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const HomeTab(),
                          transitionDuration: const Duration(seconds: 0)));
                });
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
