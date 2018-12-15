import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:maccms_app/pages/About.dart';
import 'package:maccms_app/pages/Statement.dart';

class My extends StatefulWidget {
  My({Key key}) : super(key: key);
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  bool isLogin = false;
  //头部
  _head(
      {Config config,
      Color backgroundColor = Colors.transparent,
      double width,
      double height}) {
    return Container(
      width: double.infinity,
      child: WaveWidget(
        config: config,
        backgroundColor: backgroundColor,
        size: Size(width, height),
        waveAmplitude: 0,
      ),
    );
  }

  //是否登录
  _isLogin() {
    if (isLogin == false) {
      return GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('立即登录',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.w100)),
                  Text(
                    '暂未开放注册,期待下一版本!',
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.chevron_right,
                size: 25,
              ),
            )
          ],
        ),
        onTap: () {
          //点击事件
          print('登录被点击');
        },
      );
    }
  }
  //功能按钮列表
  Widget _buttonListview(){
      return ListView(
        children: <Widget>[
          _buttonItem('history','images/history.png','足迹'),
          _buttonItem('feedback','images/feedback.png','反馈'),
          _buttonItem('setting','images/setting.png','设置'),
          _buttonItem('about','images/about.png','关于'),
          _buttonItem('statement','images/statement.png','免责声明')
        ],
      );
  }
  //单个块封装
  _buttonItem(String index,String image,String title){
    return GestureDetector(
            child: Container(
              padding: EdgeInsets.only(right: 15),
              height: 50,
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: Image.asset(
                        image,
                        fit: BoxFit.fill,
                        width: 25.0,
                        height: 25.0,
                  ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: Text(title,style: TextStyle(fontSize: 15),),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: Divider.createBorderSide(context, color: Colors.grey[350])
                        )
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 25,
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.chevron_right,
                        size: 25,
                        color: Color.fromARGB(255, 132, 132, 132),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: Divider.createBorderSide(context, color: Colors.grey[350])
                        )
                      ),
                    ),
                ],
              ),
            ),
          onTap: (){
            _buttonTap(index);
          },
          );
  }

  void _buttonTap(String index){
    switch (index){
      case 'about':
        Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new About();
          }));
        break;
      case 'statement':
        Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new Statement();
          }));
        break;
      default:
      print('null');
      break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          elevation: 0.0,
          color: Color.fromARGB(255, 255, 219, 79),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: _head(
              config: CustomConfig(
                gradients: [
                  [Colors.orange[300], Colors.white],
                  [Colors.orange[200], Colors.white],
                  [Colors.orange[100], Colors.white],
                  [Colors.white, Colors.white],
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.79, 0.79, 0.81, 0.81],
                blur: MaskFilter.blur(BlurStyle.outer, 10),
              ),
              //backgroundColor: Color.fromARGB(255, 255, 219, 79),
              width: MediaQuery.of(context).size.width,
              height: kToolbarHeight + 115),
        ),
        Positioned(
          top: kToolbarHeight + 10,
          left: 15,
          //right: (MediaQuery.of(context).size.width/2)-50,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                //color: Colors.red,
                image: DecorationImage(
                    image: AssetImage('images/avatar.png'), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(90),
                /*boxShadow: <BoxShadow>[
                  new BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 0),
                      blurRadius: 1.0)
                ]*/
              ),
          ),
        ),
        Positioned(
          top: kToolbarHeight + 20,
          left: 100,
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            child: _isLogin(),
          ),
        ),
        Positioned(
          top: kToolbarHeight + 115,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kBottomNavigationBarHeight -
                kToolbarHeight + 115,
            child: _buttonListview(),
          ),
        )
      ],
    );
  }
}
