import 'package:flutter/material.dart';
import 'package:maccms_app/constant.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);
  @override
  _About createState() => _About();
}

class _About extends State<About> {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1.0,
          leading: GestureDetector(
            child: Icon(Icons.chevron_left,color:Colors.black,size:25),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          title: Text("关于",style: TextStyle(fontSize: 18,color: Colors.black),)
        ),
        body: Container(
            color: Colors.white,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 70,bottom: 18),
                  child: Image.asset(Constant.logoImg,fit: BoxFit.fill,width: 130,height: 35,),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 18),
                  child: Text('您 的 私 人 影 视 大 院',style:TextStyle(fontSize:15,color:Color.fromARGB(255, 132, 132, 132))),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(13, 5, 13, 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0,color: Color.fromARGB(255, 132, 132, 132)),
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Text('V'+Constant.version,style:TextStyle(fontSize:15,color:Color.fromARGB(255, 132, 132, 132))),
                )
              ],
            ),
        ),
      );
    }
}