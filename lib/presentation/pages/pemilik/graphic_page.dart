import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../shared/theme.dart';

class ChartPage extends StatefulWidget {
  final String idResto;
  const ChartPage(this.idResto, {Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late TooltipBehavior _tooltipBehavior;
  List<GDPData> chartData = <GDPData>[];

  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(widget.idResto)
        .collection('chart')
        .get();
    List<GDPData> list = snapShotsValue.docs
        .map((e) => GDPData(e.data()['nama'], e.data()['orders']))
        .toList();
    setState(() {
      chartData = list;
    });
  }

  @override
  void initState() {
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Kopi Susu', 50),
      GDPData('Tumis Kangkung', 13),
      GDPData('Batagor', 25),
      GDPData('Nasi GOreng', 46),
    ];
    return chartData;
  }

  // _generateData(myData) {
  //   _seriesBarData.add(charts.Series(
  //       domainFn: (Chart chart, _) => chart.nama.toString(),
  //       measureFn: (Chart chart, _) => chart.orders,
  //       colorFn: (Chart chart, _) =>
  //           charts.ColorUtil.fromDartColor(Colors.amber),
  //       id: 'order',
  //       data: myData,
  //       labelAccessorFn: (Chart row, _) => row.nama));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: secondsubtitleColor,
          ),
        ),
        automaticallyImplyLeading: true,
        titleSpacing: -5,
        elevation: 1,
        title: Text(
          'Menu Saya',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: SfCircularChart(
        title: ChartTitle(text: 'Banyaknya Produk Yang Terjual'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
          PieSeries<GDPData, String>(
            dataSource: chartData,
            xValueMapper: (GDPData data, _) => data.nama,
            yValueMapper: (GDPData data, _) => data.orders,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
          )
        ],
      ),
    );
  }

  // Widget _buildBody(context) {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: FirebaseFirestore.instance
  //           .collection('restaurants')
  //           .doc(widget.idResto)
  //           .collection('chart')
  //           .snapshots(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return LinearProgressIndicator();
  //         } else {
  //           List<Chart> chartData = snapshot.data!.docs
  //               .map((documentSnapshot) => Chart.fromMap(
  //                   documentSnapshot.data() as Map<String, dynamic>))
  //               .toList();
  //           return _buildChart(context, chartData);
  //         }
  //       });
  // }

  // Widget _buildChart(BuildContext context, List<Chart> chartData) {
  //   myData = chartData;
  //   _generateData(myData);
  //   return Padding(
  //     padding: EdgeInsets.all(8.0),
  //     child: Center(
  //       child: Column(
  //         children: [
  //           Expanded(
  //               child: charts.BarChart(
  //             _seriesBarData,
  //             animate: true,
  //             animationDuration: Duration(seconds: 5),
  //             behaviors: [
  //               charts.DatumLegend(
  //                   entryTextStyle: charts.TextStyleSpec(
  //                 color: charts.MaterialPalette.purple.shadeDefault,
  //               ))
  //             ],
  //           ))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class GDPData {
  final String nama;
  final int orders;

  GDPData(this.nama, this.orders);

  // GDPData.fromMap(Map<String, dynamic> map)
  //     : assert(map['nama'] != null),
  //       assert(map['orders'] != null),
  //       nama = map['nama'],
  //       orders = map['orders'];

  // @override
  // String toString() => "Record<$nama:$orders>";
}
