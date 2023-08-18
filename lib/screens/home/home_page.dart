import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymtesis/constanst.dart';
import 'package:gymtesis/models/users.dart';
import 'package:gymtesis/screens/home/home_widget/chart.dart';
import 'package:gymtesis/screens/home/home_widget/plans.dart';
import 'package:gymtesis/screens/loading_screen.dart';
import 'package:gymtesis/services/plan_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../UI/video.dart';
import '../../services/user_data.dart';

class HomePage extends StatefulWidget {
  // String id;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cont = 0;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UsersData>(context);
    final plandata = Provider.of<PlanData>(context);

    void creaUpdaAgua(int op) async {
      isVisible = false;
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      DateTime now = DateTime.now();

      int cont = 0;
      bool existe = false;

      while (cont < userdata.users[0].cronoAgua!.length) {
        DateTime date =
            dateFormat.parse(userdata.users[0].cronoAgua![cont]!.fecha);
        existe = date.weekday == now.weekday;
        if (existe == true) {
          break;
        }
        cont++;
      }

      CronoAgua tempCrDiCa =
          CronoAgua(total: op, fecha: dateFormat.format(now));
      if (!existe) {
        await userdata.createAguaCron(tempCrDiCa);
      } else {
        tempCrDiCa = CronoAgua(
            id: userdata.users[0].cronoAgua![cont]!.id,
            total: op,
            fecha: dateFormat.format(now));
        await userdata.upDateAguaCron(tempCrDiCa);
      }
    }
    
    if (cont == 0) {
      userdata.load();
      if (userdata.isLoading) {
        return const LoadingScreen();
      }
      plandata.loadPlan(userdata.users[0].plan!);
    }

    cont = cont + 1;

    // return FutureBuilder(
    //     future: authService.readToken(context),
    //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

    //       if (snapshot.data != null && snapshot.data != '') {

    return WillPopScope(
      onWillPop: (() async {
        SystemNavigator.pop();
        return false;
      }),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBarGYM(userdata: userdata),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    userdata.users[0].gender == "Male"
                        ? 'Bienvenido!'
                        : 'Bienvenida!',
                    style: const TextStyle(
                        fontSize: 33, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userdata.users[0].fullName!,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        color: Color.fromARGB(255, 134, 134, 134)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CardPost(userdata: userdata, plandata: plandata),
                  CardPost(userdata: userdata, plandata: plandata),
                  CardPost(userdata: userdata, plandata: plandata),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 255, 255, 255),
                            Color.fromARGB(255, 255, 255, 255),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Re",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "kkkk",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(
                                              255, 153, 145, 145)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
    // } else {
    //   return const LoadingScreen();
    // }
    // });
  }
}

class CardPost extends StatelessWidget {
  const CardPost({
    super.key,
    required this.userdata,
    required this.plandata,
  });

  final UsersData userdata;
  final PlanData plandata;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: CircleAvatar(
                        radius: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: userdata.users[0].img != ""
                                ? Image.network(
                                    userdata.users[0].img!,
                                    fit: BoxFit.cover)
                                : Image.asset(
                                    "assets/img/R (5).jpg",
                                    fit: BoxFit.cover),
                          ),
                        )),
                  )),
              const SizedBox(
                width: 10,
              ),
              Text(
                userdata.users[0].fullName!,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          // Row(
          //   children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 70,
            child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: 
                               plandata.plan != null? Image.network(plandata.plan.img): const SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            plandata.plan.diasWork![0].descripcion,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          // ],
          // ),
        ],
      ),
    );
  }
}

class AppBarGYM extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGYM({
    super.key,
    required this.userdata,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final UsersData userdata;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      actions: [
        SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: CircleAvatar(
                  radius: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: userdata.users[0].img != ""
                          ? Image.network(userdata.users[0].img!,
                              fit: BoxFit.cover)
                          : Image.asset("assets/img/R (5).jpg",
                              fit: BoxFit.cover),
                    ),
                  )),
            )),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }
}
