import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>  _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSecods = twentyFiveMinutes;
  late Timer timer; // 버튼 눌렀을 때만 타이머 초기화 되도록
  bool isRunning = false;
  int totalPomodoros = 0;

  void onTick(Timer timer){
    if(totalSecods == 0){
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        totalSecods = twentyFiveMinutes;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSecods = totalSecods - 1;
      });
    }
  }

  void onStartPressed(){
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick
    );

    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds){
    var duration = Duration(seconds: seconds);
    var list = duration.toString().split(".").first.substring(2, 7);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible( // ui를 하드코딩이 아닌 비율로 조정할 수 있는 parent 위젯
            flex:1,
            child : Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSecods),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child : Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(
                  isRunning ? Icons.pause_circle_outline : Icons.play_circle_outline),
              ),
            ),
          ),
          Flexible(
            flex:1,
            child : Row(
              children: [
                Expanded( /* Expanded 위젯으로 감싸면 상위 위젯(여기서는 Row)이 차지하고 있는
                  전 영역으로 하위 위젯(영역)이 확장된다.
                */
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pomodors',
                          style : TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.displayLarge!.color,
                          )
                        ),
                        Text(
                          '$totalPomodoros',
                          style : const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w600
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}