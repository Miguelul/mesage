import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymtesis/constanst.dart';
import 'package:gymtesis/screens/home/home_widget/video/video.dart';
import 'package:gymtesis/services/plan_data.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Plans extends StatelessWidget {
   
    String namePlan;
   Plans({
    required this.namePlan,
    super.key});

  @override
  Widget build(BuildContext context) {
    final plandata = Provider.of<PlanData>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(plandata.plan.img),fit: BoxFit.fill,opacity: 130),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 100, 37, 65),
                Color.fromARGB(255, 0, 0, 0)
              ],
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
      //  SizedBox(
      //   width: width-40,
        //  child:
          Positioned(
          bottom: 20,
          left: 20,
          child: 
               SizedBox(
                width: width-40,
                 child: Text(namePlan,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeBig,
                        color: Colors.white,
                        overflow: TextOverflow.fade,
                        // softWrap: false,
                        )),
               ),
              // const Text('Upper Body',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: fontSizeBig,
              //         color: Colors.white)),
            
        
             ),
      //  ),
      Positioned(
          top: 30,
          left: 20,
          child: CupertinoButton(
            color: kBackgroundColor,
            disabledColor: Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return FadeTransition(
                      opacity: animation1,
                      child: StepperDemo(contVid: plandata.plan.diasWork!.length,),
                    );
                  },
                ),
              );
            },
            child: const Text(
              'Iniciar',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ))
    ]);
  }
}
