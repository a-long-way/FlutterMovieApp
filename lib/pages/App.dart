import 'package:flutter/material.dart';
import 'package:maccms_app/pages/Home.dart';
import 'package:maccms_app/pages/Cate.dart';
import 'package:maccms_app/pages/My.dart';
import 'package:maccms_app/MyWidGet/Base_Font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


//脚手架
class App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _AppState();
    }
}

class _AppState extends State<App>{
  int _tabIndex = 0; //bottomNavigationBar选中的index
   var _pageController = new PageController(initialPage: 0);
   //1
  final Home _home = new Home();
  final Cate _cate = new Cate();
  final My _my = new My();

  List tabPush = [new Home(),new Cate(),new My()]; //bottomNavigationBar实例集合
  var tabTitles = ['首页','类别','我的']; //bottomNavigationBar标题集合
  @override
  //绘制页面
  Widget build(BuildContext context) {
      //初始化屏幕适配
      ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
      return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      //appBar: appbars[_tabIndex],
      body: new PageView.builder(
        onPageChanged: (int index){setTapIndex(index);},
        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context,int index){
          return pageChooser(index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(icon: getTabImages(0),title: getTabTitle(0)),
          new BottomNavigationBarItem(icon: getTabImages(1),title: getTabTitle(1)),
          new BottomNavigationBarItem(icon: getTabImages(2),title: getTabTitle(2)),
        ],
        //设置显示的模式
        type: BottomNavigationBarType.fixed,
        //设置当前的索引
        currentIndex: _tabIndex,
        //tabBottom的点击监听
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
            // _pageController.animateToPage(index, duration: Duration(milliseconds: 100),curve: ElasticOutCurve(2));
             setTapIndex(index);
            //_tabIndex = index;
            //Navigator.push(Widget.context, MaterialPageRoute(builder: (context) => tabPush[_tabIndex]));
          });
        },
      ),
    );
    }
  //appbar list
  final List<Widget> appbars = [
    new AppBar( //首页搜索
        backgroundColor: Color.fromARGB(255, 255, 219, 79),
        primary: true,
        elevation: 0.0,
        title: new Container(
          decoration: new BoxDecoration(
              border: new Border.all(
                  width: 1.0, color: Color.fromARGB(255, 226, 226, 226)),
              borderRadius: new BorderRadius.all(Radius.circular(5.0)),
              color: Color.fromARGB(255, 255, 255, 255)),
          alignment: Alignment.center,
          height: 30.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new Icon(Base.sousuo,
                      size: 17.0, color: Color.fromARGB(255, 226, 226, 226)),
                  flex: 1),
              new Expanded(
                  child: new Text('热门',
                      style: TextStyle(
                          color: Color.fromARGB(255, 226, 226, 226),
                          fontSize: 17.0)),
                  flex: 9)
            ],
          ),
        ),
      ),
      new AppBar( //类别
        backgroundColor: Color.fromARGB(255, 255, 219, 79),
        primary: true,
        elevation: 0.0,
        title: new Center(child: Text('类别'))
      ),
      new AppBar(
        backgroundColor: Color.fromARGB(255, 255, 219, 79),
        primary: true,
        elevation: 0.0,
      )
  ];
  
  //设置状态
  void setTapIndex(int index){
    setState(() {
          this._tabIndex = index;
        });
  }
  //判断返回的对象实例
  Widget pageChooser(int index) {
    switch (index) {
      case 0:
        return _home;


      case 1:
        return _cate;


      case 2:
        return _my;


      default:
        return _home;

    }
  }
  //定义bottomNavigationBar　ICON 图标
  var tabImages = [
    [
      'icon_discovery.png',
      'icon_discovery_active.png'
    ],
    [
      'icon_category.png',
      'icon_category_active.png'
    ],
    [
      'icon_mine.png',
      'icon_mine_active.png'
    ]
  ];

  Text getTabTitle(int curIndex){
    return new Text(tabTitles[curIndex],style: TextStyle(fontSize: 13,color: Colors.black),);
  }

  Widget getTabImages(int curIndex){
    if(_tabIndex==curIndex){
      return Image.asset(
              'images/'+tabImages[curIndex][1],
              fit: BoxFit.fill,
              width: 24,
              height: 24,
          );
    }else{
      return Image.asset(
              'images/'+tabImages[curIndex][0],
              fit: BoxFit.fill,
              width: 24,
              height: 24,
          );
    }
  }
}
