import 'package:flutter/material.dart';
//import 'package:custom_chewie/custom_chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:maccms_app/constant.dart';

class Detail extends StatefulWidget{
  final int id;
  final int rid;
  Detail(this.id,{this.rid=0});
  @override
    _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail>{
  Map<String,dynamic> data={};
  List<dynamic> vodPlayList = [];
  int vodPlayCount = 0;
  int rid = 0;
  VideoPlayerController _controller = new VideoPlayerController.network(
            '',
          );
  bool isVideoExist = true;
  Dio dio;

@override
  void initState() {
    super.initState();
    this.rid = widget.rid;
    dio = new Dio();
    print('电影id'+widget.id.toString());
    getDetail(widget.id);
  }

@override
  void dispose() {
    print('销毁播放页面');
    _controller.dispose();
    super.dispose();
  }

  Future getPlay(String playfrom,String playurl) async{
    Response data = await dio.get(Constant.apiUrl+'app/play?playfrom='+playfrom+'&playurl='+playurl);
    if(data.statusCode==200&&data.data['code']==1){
      print(data.data['playurl'].toString());
      setState(() {
          _controller = new VideoPlayerController.network(
            data.data['playurl']
          );
        });
    }else{
      setState(() {
          isVideoExist = false;    
            });
    }
    
  }

  Future getDetail(int id) async{
    Response data = await dio.get(Constant.apiUrl+'app/detail?id='+id.toString());
    if(data.statusCode==200){
      if(data.data['msg']=='获取成功'){
        setState(() {
              this.data = data.data['info'];
              this.vodPlayList = data.data['info']['vod_play_url'];
              print(vodPlayList);
              vodPlayCount = vodPlayList.length==null?0:vodPlayList.length;
            });
        getPlay(this.data['vod_play_from'],this.data['vod_play_url'][rid]['url']);
      }else{
        setState(() {
              this.isVideoExist=false;
                });
      }
    }
  }
  //影片标题
  Widget _title(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      alignment: Alignment.centerLeft,
      child: Text(data['vod_name'].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),maxLines: 1,overflow: TextOverflow.clip,),
    );
  }

  Widget _laiyuan(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
      alignment: Alignment.centerLeft,
      child: Text('来源:网络',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.grey),maxLines: 1,overflow: TextOverflow.clip,),
    );
  }

  Widget _des(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
      alignment: Alignment.centerLeft,
      child: Text(data['vod_blurb'].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey),maxLines: 3,overflow: TextOverflow.clip,softWrap: true,),
    );
  }

  Widget _find(){
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,bottom: 0,top: 0),
      child: Builder(builder: (context){
            return Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                      Scaffold.of(context).showSnackBar(_snackBar('开发中，稍安勿躁-.-'));
                  },
                  icon: Icon(
                    Icons.favorite_border,
                    size: 25,
                    color: Colors.grey[400],
                  ),
                ),
                IconButton(
                  onPressed: (){
                      Scaffold.of(context).showSnackBar(_snackBar('开发中，稍安勿躁-.-'));
                  },
                  icon: Icon(
                    Icons.file_download,
                    size: 25,
                    color: Colors.grey[400],
                  ),
                ),
                IconButton(
                  onPressed: (){
                      Scaffold.of(context).showSnackBar(_snackBar('开发中，稍安勿躁-.-'));
                  },
                  icon: Icon(
                    Icons.share,
                    size: 25,
                    color: Colors.grey[400],
                  ),
                )
              ],
            );
          },
        )
    );
  }

  Widget _vodList(){
    return Container(
      width: MediaQuery.of(context).size.width-20,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Column(
        children: <Widget>[
          Container(
            height: 22,
            margin: EdgeInsets.only(top: 5,bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('选集',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),maxLines: 1,overflow: TextOverflow.clip),
                Container(
                  width: MediaQuery.of(context).size.width-50,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Icon(Icons.keyboard_arrow_right,size: 22,color: Colors.grey,),
                    onTap: (){
                      print('选集更多被按下');
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width-20,
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: vodPlayCount,
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    margin: EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(vodPlayList[index]['name'].toString(),style: TextStyle(color: this.rid==index?Colors.orange:Colors.black87,),),
                  ),
                  onTap: (){
                    print('第'+index.toString()+'集被按下');
                  },
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget _snackBar(String str){
    return SnackBar(
        content: Container(
          height: 20,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text(str,style: TextStyle(fontSize: 15,color: Colors.white),),
        ),
        backgroundColor: Color.fromARGB(100, 0, 0, 0),
        duration: Duration(seconds: 3),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
        body:Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 200,
                  //padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: Chewie(
                          _controller,
                          aspectRatio: 16 / 9,
                          autoInitialize: true,
                          autoPlay: false,
                          looping: true,
                          materialProgressColors: new ChewieProgressColors(
                            playedColor: Color.fromARGB(255, 255, 219, 79),
                            handleColor: Color.fromARGB(255, 255, 219, 79),
                            backgroundColor: Colors.grey,
                            bufferedColor: Colors.lightGreen,
                          ),
                          // Try playing around with some of these other options:

                          // showControls: false,
                          // materialProgressColors: new ChewieProgressColors(
                          //   playedColor: Colors.red,
                          //   handleColor: Colors.blue,
                          //   backgroundColor: Colors.grey,
                          //   bufferedColor: Colors.lightGreen,
                          // ),
                          // placeholder: new Container(
                          //   color: Colors.grey,
                          // ),
                          // autoInitialize: true,
                        ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white70,
                      size: 32,
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                
              ],
            ),
        Container(
              height: MediaQuery.of(context).size.height-200,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  _title(),
                  _laiyuan(),
                  _des(),
                  _find(),
                  Divider(),
                  _vodList()
                ],
              ),
            ),
          ],
        )
      );
  }
}

/*
Container(
          child:  new Chewie(
              new VideoPlayerController.network(
                'https://cdn.letv-cdn.com/2018/12/12/N5m3r36wCbDUbHWe/playlist.m3u8'
              ),
              aspectRatio: 16 / 9,
              autoPlay: true,
              looping: true,
            ),
          height: 200,
          color: Colors.black,
        )
*/