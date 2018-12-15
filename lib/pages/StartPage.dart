import 'dart:async';
import 'package:flutter/widgets.dart';


//启动页
class StartPage extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return _StatePageState();
    }
}

class _StatePageState extends State<StartPage>{
  @override
    Widget build(BuildContext context) {
      return new Container(
        child: Stack(
          children: <Widget>[
            Container(color: Color.fromARGB(
              255, 255, 219, 79),),
          ],
        ),
      );
    }
  @override
  void initState() {
      super.initState();
      countDown();
    }
  //倒计时
  void countDown() {
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration, goToApp);
  }
  //路由跳转
  void goToApp(){
    Navigator.of(context).pushReplacementNamed('/App');
  }
}