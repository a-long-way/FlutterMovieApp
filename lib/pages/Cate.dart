import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:maccms_app/constant.dart';
import 'package:maccms_app/pages/Detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; //loadding图标
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';


class Cate extends StatefulWidget {
  Cate({Key key}) : super(key: key);
  @override
  _CateState createState() => _CateState();
}

class _CateState extends State<Cate> with AutomaticKeepAliveClientMixin {
  //Map<String,dynamic> data = {};
  int total; //total为数据总量
  List<dynamic> dataList = [];
  List<dynamic> classList = [];
  int prenetId = 0;
  int start = 0; //第几个开始
  int listCount = 0; //列表数
  int listState = 0; //列表状态 0=等待 1=加载 2=没有更多
  //{'parenet':'','type_class':'','type_area':'','type_year':'','by':'hits'};
  Map<int, String> param = {0: '', 1: '不限', 2: '不限', 3: '不限', 4: '最新'};
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  Scaffold(
      appBar: new AppBar( //类别
        backgroundColor: Color.fromARGB(255, 255, 219, 79),
        primary: true,
        elevation: 0.0,
        title: new Center(child: Text('类别'))
      ),
      body: getBody(),
    );
  }
//加载菊花
  Widget getBody() {
    print(classList.length==0);
    if (classList.length!=0) {
      return LazyLoadScrollView(
        onEndOfPage: () {
          if (this.total == dataList.length && this.listState != 2) {
            setState(() {
              this.listState = 2; //设置状态为加载
              this.listCount += 1; //列表项+1
            });
          } else if (this.listState != 1 && this.listState != 2) {
            setState(() {
              this.listState = 1; //设置状态为加载
              this.listCount += 1; //列表项+1
            });
            loadMore(false);
          }
          print('listcount回调:' +
              this.total.toString() +
              'datalist:' +
              dataList.length.toString());
        },
        scrollOffset: 500,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: listCount,
          itemBuilder: (BuildContext context, int index) {
            return controller(index);
          },
        ),
      );
    } else {
      return SpinKitFadingCircle(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.yellow : Color.fromARGB(255, 255, 219, 79),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    classGet();
  }

  void classGet() async {
    Dio dio = new Dio();
    Response data = await dio.get(Constant.apiUrl + 'app/classification');
    if (data.statusCode == 200) {
      setState(() {
        classList = data.data;
        listCount = classList.length + 2;
        //print(listCount);
        param[0] = classList[0]['id'];
        loadMore(true);
      });
    }
  }


//加载更多
  void loadMore(bool isRefresh) async {
    if (isRefresh == true) {
      this.start = 0;
      listCount = classList.length + 2;
    } else {
      this.start += 21;
    }
    Dio dio = new Dio();
    Response data = await dio.get(Constant.apiUrl +
        'app/list?tid=' +
        param[0] +
        '&class=' +
        param[1] +
        '&area=' +
        param[2] +
        '&year=' +
        param[3] +
        '&by=' +
        param[4] +
        '&start=' +
        start.toString());
    if (data.statusCode == 200) {
      if (isRefresh == true) {
        //如果isrefresh==true表示为刷新或者初始化 数据覆盖，否则则新增
        setState(() {
          //this.data = data.data;
          //print(this.data);
          this.listState = 0;
          total = data.data['total'];
          dataList = data.data['list'];
          listCount = classList.length + 2 + dataList.length;
          //print(dataList);
        });
      } else {
        setState(() {
          total = data.data['total'];
          if (data.data['list'] != null) {
            this.listCount -= 1;
            this.listState = 0;
            dataList.addAll(data.data['list']);
            listCount = classList.length + 2 + dataList.length;
            //this.listState = dataList.length==total?2:0;
          } else {
            this.listState = 2;
          }

          //print(dataList);
        });
      }
    }
  }

  //控制分类
  Widget controller(int index) {
    List arr;
    bool isBottom = false;
    if (index == 0) {
      //顶级分类
      arr = classList;
      return new Container(
          color: Color.fromARGB(255, 255, 255, 255),
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          alignment: Alignment.center,
          child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: arr.length,
              itemBuilder: (context, int subindex) {
                return new GestureDetector(
                  child: new Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: 20.0),
                    child: new Text(arr[subindex]['type_name'],
                        style: TextStyle(
                            fontSize: 15.0,
                            color: prenetId == subindex
                                ? Color.fromARGB(255, 255, 219, 79)
                                : Color.fromARGB(255, 0, 0, 0))),
                  ),
                  onTap: () {
                    setState(() {
                      param[0] = arr[subindex]['id'];
                      prenetId = subindex;
                      param[1] = '不限';
                      param[2] = '不限';
                      param[3] = '不限'; //每次点击顶级分类初始化子分类
                      print(param);
                      loadMore(true); //更新列表
                    });
                  },
                );
              }));
    } else if (index <= 4) {
      var paramId;
      switch (index) {
        case 1:
          paramId = 1;
          arr = classList[prenetId]['type_class'];
          break;
        case 2:
          paramId = 2;
          arr = classList[prenetId]['type_area'];
          break;
        case 3:
          paramId = 3;
          arr = classList[prenetId]['type_year'];
          break;
        case 4:
          paramId = 4;
          arr = ['最新', '最热'];
          isBottom = true;
          break;
      }
      return classScroll(paramId, arr, isBottom);
    } else {
      if (index == 5) {
        return new Container(
          width: MediaQuery.of(context).size.width,
          height: 15.0,
        );
      }
      //print('index:'+index.toString()+'listcount:'+listCount.toString());
      if (index == listCount - 1 && listState == 2) {
        return new Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 255, 255, 255),
          height: 30.0,
          child: Center(
            child: Text('我也是有底线的-.-',
                style: TextStyle(fontSize: 15.0, color: Colors.grey)),
          ),
        );
      } else if (index == listCount - 1 && listState == 1) {
        return new Container(
          color: Color.fromARGB(255, 255, 255, 255),
          width: MediaQuery.of(context).size.width,
          height: 30.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SpinKitFadingCircle(
                size: 15.0,
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              ),
              new Text('不要急嘛！等一下咯 -.-',
                  style: TextStyle(fontSize: 15.0, color: Colors.grey))
            ],
          ),
        );
      }else{
        print(index);
        return item(dataList[index - 6]);
      }
    }
  }

  //顶级分类Scroll arr传入分类组，
  Widget classScroll(int paramId, List<dynamic> arr, bool isBottomView) {
    double itemContainerBottomPadding =
        isBottomView ? 10.0 : 0.0; //最后一个scroll加一个底部边距
    double itemContainerHeight = isBottomView ? 50.0 : 40.0; //最后一个高度加一个10.0
    Widget itemScroll = new Container(
      color: Color.fromARGB(255, 255, 255, 255),
      padding:
          EdgeInsets.fromLTRB(10.0, 10.0, 10.0, itemContainerBottomPadding),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      height: itemContainerHeight,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: arr.length,
        itemBuilder: (context, int subindex) {
          return classButton(paramId, arr[subindex]);
        },
      ),
    );
    return itemScroll;
  }

  //分类的按钮 参数为index和一个按钮集 parenet 是那种分类，0是顶级，1是分类，2是地区，3是年代，4是排序
  Widget classButton(int paramId, String str) {
    var textColor = param[paramId] == str
        ? Color.fromARGB(255, 255, 219, 79)
        : Color.fromARGB(255, 0, 0, 0);
    return new GestureDetector(
      child: new Container(
        alignment: Alignment.center,
        child:
            new Text(str, style: TextStyle(fontSize: 15.0, color: textColor)),
        margin: EdgeInsets.only(right: 20.0),
      ),
      onTap: () {
        setState(() {
          param[paramId] = str;
          loadMore(true); //更新列表
        });
      },
    );
  }

  Widget item(Map<String, dynamic> data) {
    return new GestureDetector(
      child: new Container(
        width: MediaQuery.of(context).size.width,
        height: 140.0,
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        color: Color.fromARGB(255, 255, 255, 255),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.network(data['vod_pic'], fit: BoxFit.fill),
            ),
            Expanded(
              flex: 6,
              child: new Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      data['vod_name'],
                      style: TextStyle(
                          fontSize: 18.0, color: Color.fromARGB(255, 0, 0, 0)),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      data['vod_area'] +
                          ' ' +
                          data['vod_lang'] +
                          ' ' +
                          data['vod_year'],
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      data['vod_director'] + ' ' + data['vod_actor'],
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      data['vod_remarks'],
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new Detail(data['vod_id']);
        }));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
