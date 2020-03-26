import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/main.dart';

class HomePage extends StatefulWidget {
  final Map params;
  HomePage({Key key,@required this.params}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _title;
  void _receiveMessage() {
    // messageChannel.setMessageHandler((message) async {
    //   print('message: $message, current page is $_title');
    //   return '返回Native端的数据';
    // });
  }

  @override
  void initState() {
    super.initState();
    _title = widget.params['title'];
    // 初始化后开始监听通过BasicMessageChannel从Native传递过来的数据
    _receiveMessage();
  }
// 通过调用方法关闭当前页面，back按钮可调用此函数
  void _closeCurrentPage() {
    FlutterBoost.singleton.closeCurrent();
  }

// 以下三个函数是通过MethodChannel实现Flutter调用Native的方法
  void _showLoading() async {
    // await platform.invokeMethod('showLoading');
  }

  void _dismissLoading() async {
    // await platform.invokeMethod('dismissLoading');
  }

  void _showTips() async {
    // await platform.invokeMethod('showTips', {'tips': '请求失败，请稍后重试'});
  }

// 此方法需要绑定到具体的事件上去
//  void _openNativePage(dynamic obj) async {
//    // 如果参数obj是model，需要调用model对应的类名.toJson()方法转为json对象
//    Map<String, dynamic> jsonObj;
//    // jsonObj = (obj as News.Result).toJson();
//
//    // 因为我要跳转native的页面故加一个type字段
//    // 每个Flutter的页面都是从native调用进行实例化FlutterViewContainer的
//    // native通过解析此处的type字段决定跳转Native还是Flutter页面
//    jsonObj["type"] = "App";
//    FlutterBoost.singleton.open("news_detail", urlParams:jsonObj);
//  }
  void _openNativePage() async {
    // 如果参数obj是model，需要调用model对应的类名.toJson()方法转为json对象
    Map<String, dynamic> jsonObj;
    // jsonObj = (obj as News.Result).toJson();

    // 因为我要跳转native的页面故加一个type字段
    // 每个Flutter的页面都是从native调用进行实例化FlutterViewContainer的
    // native通过解析此处的type字段决定跳转Native还是Flutter页面
    jsonObj["type"] = "App";
    FlutterBoost.singleton.open("nativeapp", urlParams:jsonObj);
    // FlutterBoost.singleton.open("nativeapp", urlParams:jsonObj);
  }
  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
                '这是一个Flutter的页面$_title'
            ),
          ),
          Container(
            height: 46,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(15, 100, 15, 10),
            decoration: new BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(23.0)
              ),
            ),
            child: MaterialButton(
              minWidth: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '跳转原生',
                  )
                ],
              ),
              onPressed:(){
                _openNativePage();
              },
            ),
          )
        ],
      ) ,
    );
  }
}