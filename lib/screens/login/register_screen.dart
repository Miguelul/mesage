import 'package:flutter/material.dart';
import 'package:gymtesis/models/users.dart';
import 'package:gymtesis/screens/home/home_tab.dart';
import 'package:gymtesis/services/notifications_service.dart';
import 'package:gymtesis/services/user_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../UI/input_decorations.dart';
import '../../constanst.dart';
import '../../provider/login_form_provider.dart';
import '../../services/auth_service.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text('Únete',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color.fromARGB(255, 116, 113, 113))),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(), child: _LoginForm())
                  ],
                ),
                const SizedBox(height: 4),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return FadeTransition(
                              opacity: animation1,
                              child: const LoginScreen(),
                            );
                          },
                        ),
                      );
                    },
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.indigo.withOpacity(0.1)),
                        shape:
                            MaterialStateProperty.all(const StadiumBorder())),
                    child: const Text(
                      '¿Ya tienes una cuenta?',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    )),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final userdata = Provider.of<UsersData>(context);
  



    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              // inputFormatters: [maskFormatter],
              controller: myController,
              autocorrect: false,
              obscureText: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '',
                  labelText: 'Nombre Completo',
                  
                  // prefixIcon: CupertinoIcons.hourglass
                  ),
              validator: (value) {
                return (value!.isNotEmpty) ? null : 'Ingrese su Nombre';
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              controller: myController2,
              // obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Edad',
                // prefixIcon: Icons.nu
              ),
              // onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'Ingresa tu Edad';
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              // inputFormatters: [maskFormatter],
            
              readOnly: true,
              controller: myController3,
decoration: InputDecorations.authInputDecoration(
                  hintText: '',
                  labelText: 'Fecha de Nacimiento',
                      prefixIcon: Icons.calendar_month),
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                if (date != null) {
                  myController3.text = DateFormat('dd/MM/yyyy').format(date);
                }
              },
               validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'Seleccione la Fecha';
              },
            ),
          
            const SizedBox(height: 20),
            TextFormField(
              // inputFormatters: [maskFormatter],
              // controller: myController,
              autocorrect: false,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '',
                  labelText: 'Correo',
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
                  hintText: '',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            const SizedBox(height: 30),
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

                        final String? errorMessage = await authService
                            .createUser(loginForm.email, loginForm.password);

                        if (errorMessage == null) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return FadeTransition(
                                  opacity: animation1,
                                  child: const HomeTab(),
                                );
                              },
                            ),
                          );
                          userdata.tempUser = User(
                            nombre: myController.text,
                            apellido: myController2.text
                         );
                              

                          final id = await authService.readToken();
                          await userdata.createUser(userdata.tempUser, id);
                          await userdata.load();
                        } else {
                          loginForm.isLoading = false;

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
