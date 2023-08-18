import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constanst.dart';

class InfoConte extends StatelessWidget {
  final String label, labelImpu;
  final String ?labelBut;
  final VoidCallback? miFuncion;
  const InfoConte(
      {super.key,
      required this.label,
      required this.labelImpu,
      this.miFuncion,
      this.labelBut});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: kTextColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: kSeconColor,
                width: 2.0,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    labelImpu,
                    style: const TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const Spacer(),

                Visibility(
                  visible: labelBut!="null",
                  child: TextButton(
                      onPressed: () {
                        miFuncion!();
                      },
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Colors.indigo.withOpacity(0.1)),
                          shape:
                              MaterialStateProperty.all(const StadiumBorder())),
                      child: Text(
                        labelBut!,
                        style:
                            const TextStyle(fontSize: 15.5, color: kPrimaryColor),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class InfoConte1 extends StatelessWidget {
  final String label, labelImpu;
  final String ?labelBut;
  final VoidCallback? miFuncion;
  const InfoConte1(
      {super.key,
      required this.label,
      required this.labelImpu,
      this.miFuncion,
      this.labelBut});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Text(
            labelImpu,
            style: const TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
          
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "364 Following    61.3K Followers",
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 14),
                  ),
                ),
                const Spacer(),

               
               CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: kPrimaryColor,
                      onPressed: () {
                        miFuncion!();
                      },
                     
                      child: Text(
                        labelBut!,
                        style:
                            const TextStyle(fontSize: 15.5, color: Colors.white),
                      )),
           
           
              ],
            ),
          )
        ],
      ),
    );
  }
}
