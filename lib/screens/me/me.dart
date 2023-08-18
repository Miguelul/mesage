import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymtesis/screens/loading_screen.dart';
import 'package:gymtesis/screens/login/login_screen.dart';
import 'package:gymtesis/screens/me/widget/ingresar_data.dart';
import 'package:gymtesis/screens/me/widget/up_date_edad.dart';
import 'package:gymtesis/screens/me/widget/up_date_fecha.dart';
import 'package:provider/provider.dart';

import '../../constanst.dart';
import '../../services/auth_service.dart';
import '../../services/plan_data.dart';
import '../../services/user_data.dart';
import '../home/home_page.dart';
import 'widget/circulavator.dart';
import 'widget/infocon.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userdata = Provider.of<UsersData>(context);

    if (userdata.isLoading) {
      return const LoadingScreen();
    }
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: kBackgroundColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          automaticallyImplyLeading: false,
          elevation: 0.2,
          title: Row(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      width: 100,
                      height: 40,
                      child: Image.asset("assets/img/flexifi.png")),
                ],
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: authService.readEmail(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                return SingleChildScrollView(
                    child: SizedBox(
                  width: double.infinity,
                  // height: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const CircularAbata(),
                          InfoConte(
                            label: 'Nombre',
                            labelImpu: userdata.users[0].fullName!,
                            miFuncion: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return FadeTransition(
                                      opacity: animation1,
                                      child: UpDate(
                                          fullName:
                                              userdata.users[0].fullName!),
                                    );
                                  },
                                ),
                              );
                            },
                            labelBut: 'Cambiar',
                          ),
                          InfoConte(
                            label: 'Edad',
                            labelImpu: userdata.users[0].edad.toString(),
                            miFuncion: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return FadeTransition(
                                      opacity: animation1,
                                      child: UpDateEdad(
                                          fullName: userdata.users[0].edad!),
                                    );
                                  },
                                ),
                              );
                            },
                            labelBut: 'Cambiar',
                          ),
                          InfoConte(
                            label: 'Fecha de nacimiento ',
                            labelImpu: userdata.users[0].fechaNaci!,
                            miFuncion: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return FadeTransition(
                                      opacity: animation1,
                                      child: UpDateFecha(
                                          fullName:
                                              userdata.users[0].fechaNaci!),
                                    );
                                  },
                                ),
                              );
                            },
                            labelBut: 'Cambiar',
                          ),
                          InfoConte(
                            label: 'Correo electrónico',
                            labelImpu: snapshot.data!,
                            labelBut: 'null',
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CupertinoButton(
                            color: kPrimaryColor,
                            disabledColor: Colors.grey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            onPressed: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("Cerrar la Seción"),
                                      content: const Text(
                                          "Está seguro de que quieres cerrar la seción?"),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: const Text("SI"),
                                            onPressed: () async {
                                              await userdata.cleanUser();
                                              userdata.isLoading = true;
                                              authService.logout();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation1, animation2) {
                                                    return FadeTransition(
                                                      opacity: animation1,
                                                      child:
                                                          const LoginScreen(),
                                                    );
                                                  },
                                                ),
                                              );
                                            }),
                                        CupertinoDialogAction(
                                            child: const Text("NO"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    );
                                  });
                            },
                            child: const Text('Cerrar Sesión'),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ]),
                  ),
                ));
              } else {
                return const LoadingScreen();
              }
            }));
  }
}


class MePage1 extends StatelessWidget {
  const MePage1({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userdata = Provider.of<UsersData>(context);
     final plandata = Provider.of<PlanData>(context);
    if (userdata.isLoading) {
      return const LoadingScreen();
    }
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: kBackgroundColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          automaticallyImplyLeading: false,
          elevation: 0.2,
          title: Row(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      width: 100,
                      height: 40,
                      child: Image.asset("assets/img/flexifi.png")),
                ],
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: authService.readEmail(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                return SingleChildScrollView(
                    child: SizedBox(
                  width: double.infinity,
                  // height: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const CircularAbata(),
                          InfoConte1(
                           label: "s",
                            labelImpu: userdata.users[0].fullName!,
                            miFuncion: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return FadeTransition(
                                      opacity: animation1,
                                      child: UpDate2(
                                          fullName:
                                              userdata.users[0].fullName!),
                                    );
                                  },
                                ),
                              );
                            },
                            labelBut: 'New Post',
                          ),
                       
                      Text("Mi post",style: TextStyle(fontSize: 18),),
                     CardPost(userdata: userdata, plandata: plandata),
                          const SizedBox(
                            height: 20,
                          )
                        ]),
                  ),
                ));
              } else {
                return const LoadingScreen();
              }
            }));
  }
}
