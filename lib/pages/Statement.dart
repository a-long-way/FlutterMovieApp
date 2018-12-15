import 'package:flutter/material.dart';
import 'package:maccms_app/constant.dart';

class Statement extends StatefulWidget {
  Statement({Key key}) : super(key: key);
  @override
  _Statement createState() => _Statement();
}

class _Statement extends State<Statement> {
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
          title: Text("免责声明",style: TextStyle(fontSize: 18,color: Colors.black),)
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              color: Colors.white,
              child: Text('1. 本APP属非赢利性质，不提供任何视听上传服务，所有内容均来自视频分享站点所提供的公开引用资源，所有视频及图文版权均归原作者及其网站所有。本APP不存储，不修改界面内容。视频数据流也不经由本公司服务器中转或存储。本站将竭尽所能注明资源来源，但由于互联网转载的不可预性，无法确认所有内容的版权所有人。若原作者对本站所载视频作品版权的归属存有异议，请联系我们，我们将在第一时间予以删除。\n\n2. 任何存在于APP上的视频、图文资料均系他人制作或提供，仅为个人观点，不代表本APP立场。\n\n3. 本APP对网络视频的聚合和分类，是根据用户观看习惯做的浏览引导，这样可以方便用户更快捷的找到相应的视频，本APP并没有对任何视频做编辑和整理。\n\n4. 您应该对浏览使用本APP一切服务自行承担风险。我们不做任何形式的保证：不保证站内搜索结果满足您的要求，不保证网站服务不中断，不保证视频及图文资源的安全性、正确性、及时性、合法性。因网络状况、通讯线路、第三方网站等任何原因而导致您不能正常使用本APP，本APP不承担任何法律责任。\n\n5. 本APP尊重并保护所有使用本APP用户的个人隐私权，您注册的用户名、电子邮件地址等个人资料，非经您亲自许可或根据相关法律、法规的强制性规定，我们不会主动地泄露给第三方。\n\n6. 任何单位或个人认为通过我们提供的内容可能涉嫌侵犯其信息网络传播权，应该及时向我们提出书面权利通知，并提供相关证明、权属证明及详细侵权情况证明。我们在收到上述法律文件后，将会尽快采取措施并断开相关链接内容。\n\n7. 我们一切资源仅为学习交流娱乐所用，请在下载后24小时内删除，未经版权许可，任何单位或个人不得将本站内容或服务用于商业目的。\n\n8. 我们本着在未改变视频内容的提供主体情况下为用户提供视频链接的网络服务，并将竭力确保版权方并未失去对视频内容传播的控制权，我们将积极主动地维护广大网民及视频创造者的合法权益，维护公众利益共建和谐网络环境，以鼓励视频创造者创做更多优质内容让更多用户看到。在版权保护的道路上，我们愿意积极配合版权方做出快速有效的回应。'),
            )
          ],
        )
      );
    }
}