import 'dart:async';

import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/colors.dart';
import '../constants/values.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Icon icon = Icon(Icons.play_arrow, color: whiteColor, size: iconsizevalue);
  bool isStart = false;
  List<String> list = [];

  int saat = 0;
  int dakika = 0;
  int saniye = 0;
  int milisaniye = 0;
  Timer? _timer;

  void _start() {
    setState(() {
      isStart = !isStart;
      if (isStart) {
        icon = Icon(
          Icons.pause,
          color: whiteColor,
          size: iconsizevalue,
        );
        const oneSec = const Duration(milliseconds: 1);
        _timer = new Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
            milisaniye++;
            if (milisaniye == 100) {
              saniye++;
              milisaniye = 0;
            }
            if (saniye == 60) {
              saniye = 0;
              dakika++;
            }
            if (dakika == 60) {
              dakika = 0;
              saat++;
            }
          }),
        );
      } else {
        icon = Icon(
          Icons.play_arrow,
          color: whiteColor,
          size: iconsizevalue,
        );
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mythemeColor,
      body: Column(children: [
        Expanded(
            flex: 2,
            child: Container(
              color: mythemeColor,
              child: Center(
                child: Container(
                  child: Text(
                    "$saat : $dakika : $saniye : $milisaniye",
                    style: TextStyle(color: whiteColor, fontSize: 45),
                  ),
                ),
              ),
            )),
        Expanded(
            flex: 4,
            child: Padding(
                padding: const EdgeInsets.all(paddingvalue),
                child: Container(
                    color: mythemeColor,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: _start,
                          child: ClayContainer(
                            child: icon,
                            color: mythemeColor,
                            height: 100,
                            width: 100,
                            borderRadius: 75,
                            curveType: CurveType.convex,
                          ),
                        ),
                      ),
                      Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(paddingvalue),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  saat = 00;
                                  dakika = 00;
                                  saniye = 00;
                                  milisaniye = 00;
                                });
                              },
                              child: MyClayContainer(btntxt: "Sıfırla"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(paddingvalue),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  list.add(
                                      "$saat : $dakika : $saniye : $milisaniye");
                                });
                              },
                              child: MyClayContainer(
                                btntxt: "Tur Ekle",
                              )),
                        ))
                      ]),
                    ])))),
        Expanded(
          flex: 4,
          child: Padding(
            padding:
                const EdgeInsets.only(left: paddingvalue, right: paddingvalue),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: bottomboxColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusvalue),
                              topRight: Radius.circular(radiusvalue))),
                    )),
                Expanded(
                  flex: 9,
                  child: Container(
                    color: bottomboxColor,
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: paddingvalue, right: paddingvalue),
                          child: Text(
                            list[index],
                            style: TextStyle(color: whiteColor, fontSize: 25),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class MyClayContainer extends StatelessWidget {
  final String btntxt;
  const MyClayContainer({
    required this.btntxt,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      child: Center(
          child: Text(
        btntxt,
        style: TextStyle(
            color: whiteColor, fontSize: 25, fontWeight: FontWeight.bold),
      )),
      color: mythemeColor,
      height: 75,
      width: 75,
      borderRadius: radiusvalue,
      curveType: CurveType.convex,
    );
  }
}
