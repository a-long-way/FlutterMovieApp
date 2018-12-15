import 'package:flutter/material.dart';
import 'package:maccms_app/pages/App.dart';
import 'package:maccms_app/pages/StartPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:maccms_app/constant.dart';

void main() {
  
  TargetPlatform platform = defaultTargetPlatform;
        if (platform != TargetPlatform.iOS)
        {
            SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
            SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
            //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
        }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp( new MaterialApp(
    title:Constant.name,
    theme: new ThemeData(
      primarySwatch: Colors.orange
    ),
    home:new StartPage(),
    routes:{
        '/App':(BuildContext context)=>App(),
    },
    )
  );
} 

