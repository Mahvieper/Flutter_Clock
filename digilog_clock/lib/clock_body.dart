import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'progress_painter.dart';


class ClockBody extends StatefulWidget {
  @override
  _ClockBodyState createState() => _ClockBodyState();
}

class _ClockBodyState extends State<ClockBody>
    with SingleTickerProviderStateMixin {
  var _now = new DateTime.now();
  double _percentage;
  double _nextPercentage;
  Timer _timer;
  AnimationController _progressAnimationController;
  bool isSelected = false;
  List<String> getDay = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  @override
  initState() {
    super.initState();
    _percentage = 0.0;
    _nextPercentage = double.parse((_now.second).toString()) + 1;
    _timer = null;
    _now = new DateTime.now();
    initAnimationController();
    startProgress();
  }

  initAnimationController() {
    _progressAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {
              _percentage = lerpDouble(_percentage, _nextPercentage,
                  _progressAnimationController.value);
              _now = new DateTime.now();
            });
          });
    _progressAnimationController.forward(from: 1.0);
  }

  start() {
    Timer.periodic(Duration(seconds: 1), handleTicker);
  }

  handleTicker(Timer timer) {
    setState(() {
      _now = new DateTime.now();
    });

    _timer = timer;
    if (_nextPercentage < 61.0) {
      publishProgress();
    } else {
      timer.cancel();
      startProgress();
    }
  }

  startProgress() {
    if (null != _timer && _timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      _now = new DateTime.now();
      _percentage = 0.0;
      _nextPercentage = double.parse((_now.second).toString()) +1 ;
      //_nextPercentage =  double.parse((_thisTime*60*60+_now.minute*60+_now.second).toString());
      start();
    });
  }

  publishProgress() {
    _percentage = _nextPercentage;
    setState(() {
      _nextPercentage = double.parse((_now.second).toString()) +1;
    });
  }

  getProgressText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //DateFormat.jm() gives date as formatted time.
        (DateFormat.jm().format(getCurrentTime()).toString().contains("AM") &&
                    (getCurrentTime().hour % 12) >
                        6) || //if AM and Time Greater than 6
                (DateFormat.jm()
                        .format(getCurrentTime())
                        .toString()
                        .contains("PM") &&
                    (getCurrentTime().hour % 12) < 6)
            ? //if PM and Time less than 6
            Image.asset(
                "images/sun.png",
                color: Colors.white,
                width: 40,
                height: 40,
              )
            : //Then Sun.
            Image.asset("images/moon.png",
                color: Colors.white, width: 30, height: 30), //Else Moon.

        SizedBox(
          height: 10,
        ),

        Container(
          margin: EdgeInsets.only(right: 8),
          child: RichText(
            text: TextSpan(
                text: ((getCurrentTime().hour % 12)).toString().length < 2
                    ? '0${((getCurrentTime().hour % 12)).toInt()}'
                    : '${((getCurrentTime().hour % 12)).toInt()}',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'RobotoCondensed'),
                children: <TextSpan>[
                  TextSpan(
                      text: '  :  ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(
                    text: (getCurrentTime().minute).toString().length < 2
                        ? '0${(getCurrentTime().minute).toInt()}'
                        : '${(getCurrentTime().minute).toInt()}',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'RobotoCondensed'),
                  ),
                ]),
          ),
        ),

        SizedBox(
          height: 10,
        ),

        Text(
          '${getDay[getCurrentTime().weekday % 7]}',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ), //Printing the Weekday. eg - Sunday,Monday...etc

        SizedBox(
          height: 10,
        ),

        Text(
          '${DateFormat.yMMMd().format(getCurrentTime())}',
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ) //Printing the Month Date and Year.
      ],
    );
  }

  progressView() {
    return CustomPaint(
      child: Center(
        child: getProgressText(),
      ),
      foregroundPainter: ProgressPainter(
          defaultCircleColor: Colors.grey,
          percentageCompletedCircleColor:
              Colors.redAccent, // The Second's Progress Color.
          percentageCompleted: _percentage,
          circleWidth: 50.0),
    );
  }

  getCurrentTime() {
    return DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(30.0),
            child: progressView(),
          ),
        ],
      ),
    );
  }
}
