import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Mycharts extends StatefulWidget {
  const Mycharts({super.key});

  @override
  State<Mycharts> createState() => _MychartsState();
}

class _MychartsState extends State<Mycharts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: TextButton(
                    onPressed: () {}, child: const Text("bar chart"))),
            Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const Chart2();
                      }));
                    },
                    child: const Text("pie chart"))),
            Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const Chart1();
                      }));
                    },
                    child: const Text("line chart"))),
          ],
        ));
  }
}

class Chart2 extends StatefulWidget {
  const Chart2({super.key});

  @override
  State<Chart2> createState() => _Chart2State();
}

class _Chart2State extends State<Chart2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AspectRatio(
      aspectRatio: 1,
      child: PieChart(PieChartData(sections: [
        PieChartSectionData(
            radius: 100,
            color: const Color.fromARGB(255, 135, 86, 82),
            value: 90),
        PieChartSectionData(radius: 100, color: Colors.red, value: 100),
        PieChartSectionData(
            radius: 100,
            color: const Color.fromARGB(255, 95, 225, 25),
            value: 120),
        PieChartSectionData(
            radius: 100,
            color: const Color.fromARGB(255, 143, 124, 123),
            value: 50)
      ])),
    ));
  }
}

class Chart1 extends StatefulWidget {
  const Chart1({super.key});

  @override
  State<Chart1> createState() => _Chart1State();
}

class _Chart1State extends State<Chart1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AspectRatio(
      aspectRatio: 1,
      child: LineChart(LineChartData(
          titlesData: FlTitlesData(
              leftTitles: AxisTitles(axisNameWidget: Text("y axis")),
              bottomTitles: AxisTitles(axisNameWidget: Text("axix")),
              show: true),
          backgroundColor: Colors.pink[200],
          lineBarsData: [
            LineChartBarData(
                dotData: FlDotData(show: true),
                barWidth: 5,
                show: true,
                isCurved: true,
                spots: [
                  const FlSpot(3, 6),
                  const FlSpot(0, 6),
                  const FlSpot(3.5, 6),
                  const FlSpot(-3.2, 6),
                  const FlSpot(10, 6),
                  const FlSpot(3, 26),
                  const FlSpot(3, 6)
                ])
          ])),
    ));
  }
}
