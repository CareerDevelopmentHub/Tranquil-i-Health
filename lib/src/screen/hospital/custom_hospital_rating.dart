import 'package:flutter/material.dart';
import 'package:healthhero/src/helper/percentage_builder.dart';

import 'package:healthhero/src/screen/helper/firebase_helper.dart';
import 'package:healthhero/src/theme/app_color.dart';

class CustomHospitalRankingScreen extends StatefulWidget {
  const CustomHospitalRankingScreen({
    Key? key,
    this.appbarText,
    this.hospitalName,
  }) : super(key: key);
  final String? appbarText;
  final String? hospitalName;

  @override
  State<CustomHospitalRankingScreen> createState() =>
      _CustomHospitalRankingScreenState();
}

class _CustomHospitalRankingScreenState
    extends State<CustomHospitalRankingScreen> {
  @override
  void initState() {
    getAvgValue();
    super.initState();
  }

  late final count;
  late final score;
  late final dscore;
  late final dcount;
  late final gavg;
  late final bavg;
  late final num bpercent;
  late final num spercent;

  getAvgValue() async {
    firestore
        .collection('hospital')
        .doc(widget.hospitalName)
        .get()
        .then((value) {
      if (value.exists) {
        count = value["scount"];
        score = value["score"];
        dscore = value["dscore"];
        dcount = value["dcount"];
        print('count is $count');
        print('scount is $score');
        print('dscore is $dscore');
        print('dcount is $dcount');
        print(widget.hospitalName);
        calculateAvg(score, count, dcount, dscore);
      } else {
        setState(() {
          isEmpty = true;
        });
      }
    });
  }

  calculateAvg(num score, num count, num dcount, num dscore) {
    gavg = score / count;
    bavg = dscore / dcount;
    bpercent = -(bavg) * 100;
    spercent = gavg * 100;
    print('bavg is $bavg');
    print('gavg is $gavg');
    setState(() {
      isLoading = !isLoading;
    });
  }

  bool isLoading = true;
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.appbarText ?? ""),
      ),
      body: !isLoading
          ? Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    Container(
                      padding: const EdgeInsets.all(25),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                        child: Text(
                          '${widget.hospitalName} analysis score board',
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PercentageContainer(
                          percentage: gavg * 300,
                          color: Colors.green,
                        ),
                        PercentageContainer(
                          percentage: -(bavg) * 300,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Good is ${spercent.toStringAsFixed(2)} %'),
                        Text('Bad is ${bpercent.toStringAsFixed(2)} %'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: gavg >= -(bavg) ? greenColor : redColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: Center(
                        child: Text(
                          'System recommendation is ${gavg >= -(bavg) ? 'Good' : 'Bad'} ',
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : isEmpty
              ? const Center(
                  child: Text(
                    "No Data availabe now",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                ),
    );
  }
}
