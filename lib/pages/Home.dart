import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:maccms_app/constant.dart';
import 'dart:async';
import 'Detail.dart';
import 'package:maccms_app/MyWidGet/Base_Font.dart';

class Home extends StatefulWidget{
  Home({Key key}):super(key:key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{
  List<Widget> body = [];

  @override 
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
      super.build(context);
      //headerSwiper();
      //bodyList();
      return Scaffold(
        appBar: AppBar( //首页搜索
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
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers:<Widget>[
            new SliverToBoxAdapter(
              child: new Stack(children: <Widget>[
                    new Container(
                        height: 160.0, color: Color.fromARGB(255, 244, 244, 244)),
                    new Positioned(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: new Container(
                        decoration:
                            new BoxDecoration(color: Color.fromARGB(255, 255, 219, 79)),
                        height: 100.0,
                      ),
                    ),
                    new Positioned(
                      top: 0.0,
                      left: 10.0,
                      right: 10.0,
                      child: new Container(
                        height: 140.0,
                        decoration: new BoxDecoration(
                          color: Color.fromARGB(255, 132, 132, 132),
                        ),
                        child: new HeadSwiper(),
                      ),
                    )
                  ])
            ),
            new BodyList()
          ]
        ),
      );
    }

  //头部轮播图
  void headerSwiper(){
    body.add(
      new SliverToBoxAdapter(
            child: new Stack(children: <Widget>[
                  new Container(
                      height: 160.0, color: Color.fromARGB(255, 244, 244, 244)),
                  new Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: new Container(
                      decoration:
                          new BoxDecoration(color: Color.fromARGB(255, 255, 219, 79)),
                      height: 100.0,
                    ),
                  ),
                  new Positioned(
                    top: 0.0,
                    left: 10.0,
                    right: 10.0,
                    child: new Container(
                      height: 140.0,
                      decoration: new BoxDecoration(
                        color: Color.fromARGB(255, 132, 132, 132),
                      ),
                      child: new HeadSwiper(),
                    ),
                  )
                ])
          )
    );
  }//end头部轮播

  //首页列表
  void bodyList(){
    body.add(BodyList());
  }//end首页列表

  
}

//轮播网络取数据类
class HeadSwiper extends StatefulWidget {
  @override
  _HeadSwiperState createState() => _HeadSwiperState();
}

class _HeadSwiperState extends State<HeadSwiper> {
    Response img;
  List<dynamic> imglist;
  int imgcount=0;
  @override
  Widget build(BuildContext context) {
    return new Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return new Image.network(
          imglist[index]['src'],
          fit: BoxFit.fill,
        );
      },
      itemCount: imgcount,
      onTap: (int index){onTap(index);},
    );
  }

  onTap(int index){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
          return new Detail(imglist[index]['id']);
        }));
  }

  Future imget() async {
    Dio dio = new Dio();
    img = await dio.get(Constant.apiUrl + 'app/swiper');
    if(img.statusCode==200){
        setState(() {
                  imglist = img.data;
                  imgcount = imglist.length;
                });
        
    }
  }

  static SlideTransition createTransition(
  Animation<double> animation, Widget child) {
    return new SlideTransition(
        position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
    ).animate(animation),
        child: child,
    );
  }
  @override
  void initState(){
      super.initState();
      imget();
    }  
}//end轮播网络取数据类


class BodyList extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return _BodyListState();
    }
}

class _BodyListState extends State<BodyList>{
    List<dynamic> apiList;
    int apiCount=0;
    //List<Widget> list = [];
    @override
      Widget build(BuildContext context) {        
        return new SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context,int index){
            return buildItem(index);
          },childCount: apiCount),
        );
      }

    Future apiGet() async{
      Dio dio = new Dio();
      Response apidata = await dio.get(Constant.apiUrl+'app/home_category');
      if(apidata.statusCode==200){
        setState(() {
                  this.apiList = apidata.data;
                  apiCount = this.apiList.length;
                  print(this.apiList[0]);
                });
      }
    }

    Widget buildItem(int index){
      List<dynamic> itemCount = apiList[index]['list'];
      //卡片内标题
      Widget headTitle = new Container(
        height: 50.0,
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child:new Image.asset('images/heji.png',width: 30.0,height: 30.0) ,
          ),
          Expanded(
            flex: 9,
            child:new Text(apiList[index]['name'],
            style:TextStyle(
              fontSize: 20.0
            )
           ) 
          )
        ],
      ),
      );
      //卡片中左右滑动的列表
      Widget item =new Container(
        width: MediaQuery.of(context).size.width-10.0,
        height: 180.0,
        child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount.length==null?0:itemCount.length,
        itemBuilder: (BuildContext context,int subindex){
          return subItem(index,subindex);
        },
      ) 
      );

      return new Container(
        height: 240.0,
        color: Color.fromARGB(255, 255, 255, 255),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            headTitle,
            item
            
            //item
          ],
        ),
      );
    }

    Widget subItem(int index,int subindex){
      return GestureDetector(
        child:Container(
          width: 110.0,
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 4.0, 0.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           new Image.network(apiList[index]['list'][subindex]['vod_pic'],fit: BoxFit.fill,height: 150.0,width: 110.0,),
           new Text(apiList[index]['list'][subindex]['vod_name'],overflow: TextOverflow.clip,maxLines: 1,)
          ],
        ),
        ),
      onTap: (){//被点击
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
          return new Detail(apiList[index]['list'][subindex]['vod_id']);
        }));
      },
      );
    }
  //跳转动画
  

  @override
  void initState(){
    super.initState();
    apiGet();
  }
}