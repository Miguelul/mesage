import 'package:flutter/material.dart';

import 'package:gymtesis/UI/video.dart';
import 'package:gymtesis/constanst.dart';
import 'package:gymtesis/models/users.dart';
import 'package:gymtesis/screens/home/home_page.dart';
import 'package:gymtesis/services/plan_data.dart';
import 'package:gymtesis/services/user_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StepperDemo extends StatefulWidget {
  final int? contVid;

  const StepperDemo({this.contVid, super.key});

  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    final plandata = Provider.of<PlanData>(context);

    final userdata = Provider.of<UsersData>(context);

    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime now = DateTime.now();

    int cont = 0;
    bool existe = false;

    while (cont < userdata.users[0].cronoDiaWorkS!.length) {
      DateTime date =
          dateFormat.parse(userdata.users[0].cronoDiaWorkS![cont]!.fecha);
      existe = date.weekday == now.weekday;
      if (existe == true) {
        break;
      }
      cont++;
    }
    List<Step> step = List.generate(plandata.plan.diasWork!.length, (index) {
      return Step(
        title: Text(
          plandata.plan.diasWork![index].title,
          style: const TextStyle(fontSize: 18, color: Colors.black54),
        ),
        content: Column(
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
                          VideoApp(url: plandata.plan.diasWork![index].video),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        plandata.plan.diasWork![index].descripcion,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),
                    )
                  ],
                ))
          ],
        ),
      
        isActive: _currentStep >= 0,
        state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
      );
    });
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBarGYM(userdata: userdata),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              // type: stepperType,
              physics: const ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue: continued,
              onStepCancel: cancel,
              steps: step,
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
           onTap: () async {
                    CronoDiaWork tempCrDiCa =
                        CronoDiaWork(estado: true, fecha: dateFormat.format(now));
                    if (!existe) {
                      await userdata.createDiaWork(tempCrDiCa);
                    } else {
                      tempCrDiCa = CronoDiaWork(
                          id: userdata.users[0].cronoDiaWorkS![cont]!.id,
                          estado: userdata.users[0].cronoDiaWorkS![cont]!.estado
                              ? false
                              : true,
                          fecha: dateFormat.format(now));
                      await userdata.upDateDiaWork(tempCrDiCa);
                    }
                  },
        child: Container(
          width: 110,
          height: 50,
          decoration: BoxDecoration(
           color: existe? userdata.users[0].cronoDiaWorkS![cont]!.estado
                        ? const Color.fromARGB(236, 89, 245, 193)
                        : const Color.fromARGB(236, 116, 116, 116):const Color.fromARGB(236, 107, 107, 107),
                      borderRadius: BorderRadius.circular(100)  
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const Padding(
               padding: EdgeInsets.all(8.0),
               child: Text("Hoy",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
             ),
              Padding(
                padding: const EdgeInsets.only(right: 4,bottom: 5),
                child:  Icon( Icons.check_circle_sharp,
                    
                      size: 50,
                      color: existe? userdata.users[0].cronoDiaWorkS![cont]!.estado
                            ? const Color.fromARGB(235, 237, 255, 248)
                            : const Color.fromARGB(235, 167, 167, 167):const Color.fromARGB(235, 172, 172, 172),
                            
                    ),
                  
              ),
                
            ],
          ),
        ),
      ),
    
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < (widget.contVid! != 0 ? (widget.contVid! - 1) : 0)
        ? setState(() => _currentStep += 1)
        : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
