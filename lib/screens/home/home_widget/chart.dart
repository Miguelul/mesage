import 'dart:async';


import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymtesis/constanst.dart';

import 'package:intl/intl.dart';

import '../../../models/users.dart';

// ignore: must_be_immutable
class BarChartSample2 extends StatefulWidget {
  List<CronoAgua?>? cronoAgua;

  BarChartSample2({this.cronoAgua, super.key});



  final Color barBackgroundColor = const Color.fromARGB(186, 255, 255, 255);
  final Color barColor = const Color.fromARGB(255, 0, 0, 0);
  final Color touchedBarColor = Colors.lightBlue[700]!;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample2> {
  final Duration animDuration = const Duration(milliseconds: 250);
  DateTime now = DateTime.now();
  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final userdata = widget.cronoAgua!;

    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 233, 233, 233),
          borderRadius: BorderRadius.circular(15)),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Agua',
                    style: TextStyle(
                      color: Color.fromARGB(255, 36, 37, 36),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        // isPlaying ? randomData() :
                        mainBarData(userdata),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Promedio Diario',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '3.8 L',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
    List<CronoAgua>? cronoAgua,
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 8,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(List<CronoAgua?>? cronoAgua) =>
      List.generate(7, (i) {
        switch (i) {
          case 0:
            int cont = 0;
            bool isSunday = false;
            DateFormat dateFormat = DateFormat('dd/MM/yyyy');

            while (cont < cronoAgua!.length) {
              DateTime date = dateFormat.parse(cronoAgua[cont]!.fecha);
              isSunday = date.weekday == 1;
              if (isSunday == true) {
                break;
              }
              cont++;
            }
            if (isSunday == true) {
              return makeGroupData(0, cronoAgua[cont]!.total.toDouble(),
                  isTouched: i == touchedIndex);
            } else {
              return makeGroupData(0, 0, isTouched: i == touchedIndex);
            }

          case 1:
            int cont = 0;
            bool isSunday = false;
            DateFormat dateFormat = DateFormat('dd/MM/yyyy');

            while (cont < cronoAgua!.length) {
              DateTime date = dateFormat.parse(cronoAgua[cont]!.fecha);
              isSunday = date.weekday == 2;
              if (isSunday == true) {
                break;
              }
              cont++;
            }

            if (isSunday == true) {
              return makeGroupData(1, cronoAgua[cont]!.total.toDouble(),
                  isTouched: i == touchedIndex);
            } else {
              return makeGroupData(1, 0, isTouched: i == touchedIndex);
            }

          case 2:
            int cont = 0;
            bool isSunday = false;
            DateFormat dateFormat = DateFormat('dd/MM/yyyy');

            while (cont < cronoAgua!.length) {
              DateTime date = dateFormat.parse(cronoAgua[cont]!.fecha);
              isSunday = date.weekday == 3;
              if (isSunday == true) {
                break;
              }
              cont++;
            }
            if (isSunday == true) {
              return makeGroupData(2, cronoAgua[cont]!.total.toDouble(),
                  isTouched: i == touchedIndex);
            } else {
              return makeGroupData(2, 0, isTouched: i == touchedIndex);
            }

          case 3:
            int cont = 0;
            bool isSunday = false;
            DateFormat dateFormat = DateFormat('dd/MM/yyyy');

            while (cont < cronoAgua!.length) {
              DateTime date = dateFormat.parse(cronoAgua[cont]!.fecha);
              isSunday = date.weekday == 4;

              if (isSunday == true) {
                break;
              }
              cont++;
            }

            if (isSunday == true) {
              return makeGroupData(3, cronoAgua[cont]!.total.toDouble(),
                  isTouched: i == touchedIndex);
            } else {
              return makeGroupData(3, 0, isTouched: i == touchedIndex);
            }

          case 4:
            int cont = 0;
            bool isSunday = false;
            DateFormat dateFormat = DateFormat('dd/MM/yyyy');

            while (cont < cronoAgua!.length) {
              DateTime date = dateFormat.parse(cronoAgua[cont]!.fecha);
              isSunday = date.weekday == 5;
              if (isSunday == true) {
                break;
              }
              cont++;
            }
            if (isSunday == true) {
              return makeGroupData(4, cronoAgua[cont]!.total.toDouble(),
                  isTouched: i == touchedIndex);
            } else {
              return makeGroupData(4, 0, isTouched: i == touchedIndex);
            }

          case 5:
            int cont = 0;
            bool isSunday = false;
            DateFormat dateFormat = DateFormat('dd/MM/yyyy');

            while (cont < cronoAgua!.length) {
              DateTime date = dateFormat.parse(cronoAgua[cont]!.fecha);
              isSunday = date.weekday == 6;
              if (isSunday == true) {
                break;
              }
              cont++;
            }
           
            if (isSunday == true) {
              return makeGroupData(5, cronoAgua[cont]!.total.toDouble(),
                  isTouched: i == touchedIndex);
            } else {
              return makeGroupData(5, 0, isTouched: i == touchedIndex);
            }

          case 6:
            int cont = 0;
            bool isSunday = false;
            DateFormat dateFormat = DateFormat('dd/MM/yyyy');

            while (cont < cronoAgua!.length) {
              DateTime date = dateFormat.parse(cronoAgua[cont]!.fecha);
              isSunday = date.weekday == 7;
              if (isSunday == true) {
                break;
              }
              cont++;
            }
            if (isSunday == true) {
              return makeGroupData(6, cronoAgua[cont]!.total.toDouble(),
                  isTouched: i == touchedIndex);
            } else {
              return makeGroupData(6, 0, isTouched: i == touchedIndex);
            }

          default:
            return throw Error();
        }
      });

  BarChartData mainBarData(List<CronoAgua?>? cronoAgua) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: const Color.fromARGB(255, 81, 89, 94).withOpacity(0.3),
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Lunes';
                break;
              case 1:
                weekDay = 'Martes';
                break;
              case 2:
                weekDay = 'Miercoles';
                break;
              case 3:
                weekDay = 'Jueves';
                break;
              case 4:
                weekDay = 'Viernes';
                break;
              case 5:
                weekDay = 'Sabado';
                break;
              case 6:
                weekDay = 'Domingo';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(cronoAgua),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: kPrimaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('L', style: style);
        break;
      case 1:
        text = const Text('M', style: style);
        break;
      case 2:
        text = const Text('Mi', style: style);
        break;
      case 3:
        text = const Text('J', style: style);
        break;
      case 4:
        text = const Text('V', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('D', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  // BarChartData randomData() {
  //   return BarChartData(
  //     barTouchData: BarTouchData(
  //       enabled: false,
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: getTitles,
  //           reservedSize: 38,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //       topTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //       rightTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: false,
  //     ),
  //     barGroups: List.generate(7, (i) {
  //       switch (i) {
  //         case 0:
  //           return makeGroupData(
  //             0,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 1:
  //           return makeGroupData(
  //             1,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 2:
  //           return makeGroupData(
  //             2,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 3:
  //           return makeGroupData(
  //             3,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 4:
  //           return makeGroupData(
  //             4,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 5:
  //           return makeGroupData(
  //             5,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 6:
  //           return makeGroupData(
  //             6,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         default:
  //           return throw Error();
  //       }
  //     }),
  //     gridData: FlGridData(show: false),
  //   );
  // }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}