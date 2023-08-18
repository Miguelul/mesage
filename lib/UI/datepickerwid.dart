/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DateWidgetC extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;
  final Color? estadoColor;

   DateWidgetC({
    super.key,
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.estadoColor,
    this.width,
    this.onDateSelected,
    this.locale,
    this.visible =false
  });
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children:[ Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(DateFormat("MMM", locale).format(date).toUpperCase(), // Month
                style: monthTextStyle),
            const SizedBox(
              height: 6,
            ),
           
            Container(
              width: width,
              margin: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                color: selectionColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    Text(date.day.toString(), // Date
                        style: dateTextStyle),
                    Text(
                        DateFormat("E", locale)
                            .format(date)
                            .toUpperCase(), // WeekDay
                        style: dayTextStyle)
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: 15,
          left: 22,
          // right: 10,
          child:  Visibility(
              visible: visible,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                    color: estadoColor, borderRadius: BorderRadius.circular(15)),
              ),
            ),)
        ]
      ),
      onTap: () {
        // Check if onDateSelected is not null
        // if (onDateSelected != null) {
        //   // Call the onDateSelected Function
        //   onDateSelected!(this.date);
        // }
      },
    );
  }
}
