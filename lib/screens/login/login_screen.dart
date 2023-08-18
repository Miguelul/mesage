import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymtesis/screens/login/register_screen.dart';




import 'package:provider/provider.dart';

import '../../UI/input_decorations.dart';
import '../../constanst.dart';
import '../../provider/login_form_provider.dart';
import '../../provider/validator_form.dart';
import '../../services/auth_service.dart';
import '../../services/notifications_service.dart';
import '../home/home_tab.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      
      onWillPop: (() async {
        SystemNavigator.pop();
        return false;
      }),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding+8),
              child: SizedBox(
                // height: height-40,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        const SizedBox(height: 3),
                        const Text('Bienvenido',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeBig,
                                color: kTextColor)),
                        const SizedBox(height: 15),
                        const Text(
                            'Iniciar Cesión con',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: fontSize,
                                color: kTextColor)),
                                const Text(
                            'Email y Contraseña',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: fontSize,
                                color: kTextColor)),
                        const SizedBox(height: 30),
                        ChangeNotifierProvider(
                            create: (_) => LoginFormProvider(), child: _LoginForm())
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                        onPressed: () async{
              
                    
              
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return FadeTransition(
                                  opacity: animation1,
                                  child: ChangeNotifierProvider(
                                    create: (context) => ValidatorForm(),
                                    child: const RegisterScreen(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Colors.indigo.withOpacity(0.1)),
                            shape: MaterialStateProperty.all(const StadiumBorder())),
                        child: const Text(
                          'Crear una nueva cuenta',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        )),
                  
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
  double height = MediaQuery.of(context).size.height;
    return 
      
       Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SizedBox(
          height: height-height*0.5,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'maria@gmail.com',
                    labelText: 'Correo electrónico',
                    prefixIcon: Icons.account_box),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
        
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Esto no es un correo';
                },
              ),
             
             
              const SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '*****',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_outline),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'La contraseña debe de ser de 6 caracteres';
                },
              ),
            const Spacer(),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: kPrimaryColor,
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          final authService =
                              Provider.of<AuthService>(context, listen: false);
        
                          if (!loginForm.isValidForm()) return;
        
                          loginForm.isLoading = true;
        
                          final String? errorMessage = await authService.login(
                              loginForm.email, loginForm.password);
        
                          if (errorMessage == null) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) {
                                  return FadeTransition(
                                    opacity: animation1,
                                    child: const HomeTab(),
                                  );
                                },
                              ),
                            );
                          } else {
                            NotificationsService.showSnackbar(errorMessage);
                            loginForm.isLoading = false;
                          }
                        },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                      child: Text(
                        loginForm.isLoading ? 'Espere' : 'Ingresar',
                        style: const TextStyle(color: Colors.white),
                      )))
          
            ],
          ),
        ),
    
    );
  }
}
