import 'package:flutter/material.dart';
import 'package:maccms_app/MyWidGet/Base_Font.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:maccms_app/constant.dart';
import 'dart:async';
import 'Detail.dart';

class Homes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
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
      body: new Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: CustomScrollView(
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
          new SliverToBoxAdapter(
            child: new Container(
              height: 1000.0,
              color: Colors.pink,
            ),
          )
        ]
      ),
    );
  }
}

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
    Navigator.of(context).push(new PageRouteBuilder(
      pageBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation) {
      return new Detail(imglist[index]['id']);
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return createTransition(animation, child);
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
}

class Bodyinfo extends StatefulWidget{
    @override
      _BodyinfoState createState() => _BodyinfoState();
}

class _BodyinfoState extends State<Bodyinfo>{
    List<Widget> bodyinfo = [];
    @override
    Widget build(BuildContext context) {

        start();
        return ListView(
            children: bodyinfo,
        );
      }
    
    start(){
        for(int i=0;i<4;i++){
          List<Widget> subitem = [];
          for(int ii=0;ii<2;ii++){
            List<Widget> rowitem = [];
            for(int iii=0;iii<3;iii++){
              rowitem.add(
                new Card(
                  child: Column(
                    children: <Widget>[
                      new Container(
                        width: 100.0,
                        height: 140.0,
                        color: Color.fromARGB(255, 222, 222, 222),
                      ),
                      new Container(
                        width: 80.0,
                        height: 20.0,
                        color: Color.fromARGB(255, 222, 222, 222),
                        margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                      )
                    ],
                  ),
                )
              );
            }
            subitem.add(new Column(
              children: rowitem
            ));
          }
          bodyinfo.add(
            new Column(
              children: subitem,
            )
          );
        }
    }

    
}