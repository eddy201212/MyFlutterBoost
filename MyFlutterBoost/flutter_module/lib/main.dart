import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'Module/TestPage/BusinessPage.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
 
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
 
    //其中pageName为原生代码传递过来的路由名称（first，second，flutterFragment）都是路由名称 params为原生传递过来的参数 
    FlutterBoost.singleton.registerPageBuilders({
      'first': (pageName, params, _) => FirstRouteWidget(),
      'second': (pageName, params, _) => SecondRouteWidget(),
      'flutterFragment': (pageName, params, _) => FragmentRouteWidget(params),
      'BusinessPage': (pageName, params, _) => BusinessPage(params: params),
    });
 
    // FlutterBoost.h();
  }
 
 
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Boost example',
        builder: FlutterBoost.init(postPush: _onRoutePushed),
        home: Container(
        ));
  }
 
  void _onRoutePushed(
      String pageName, String uniqueId, Map params, Route route, Future _) {
  }
}
 
class FirstRouteWidget extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('与原生push一样的页面'),
            onPressed: () {
              //dart通过原生跳转dart页面
              // FlutterBoost.singleton.open("first", {
              //   "query": {"aaa": "eee","ccc":"ddd"}
              // }, animated: true);

              
            },
          ),
          RaisedButton(
            child: Text('Go back!'),
            onPressed: () {
              //关闭dart页面
              FlutterBoost.singleton.closeByContext(context);
            },
          )
        ],
      ),
    );
  }
}
 
class SecondRouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // 关闭dart页面
            FlutterBoost.singleton.closeByContext(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
 
class FragmentRouteWidget extends StatelessWidget {
  //原生传递过来的参数
  final Map params;
 
  FragmentRouteWidget(this.params);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('参数展示'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 32.0),
            child: Text(
              params['key'] ?? '',
              style: TextStyle(fontSize: 28.0, color: Colors.red),
            ),
            alignment: AlignmentDirectional.center,
          ),
          RaisedButton(
            onPressed: () {
              //dart跳转原生页面以及传递参数
              // FlutterBoost.singleton.openPage("first", {
              //   "query": {"key": "我是flutter传递的参数","type":"App"}
              // }, animated: true);

              FlutterBoost.singleton.open("sample://native", urlParams: {"query":{"type":"App"}});
 
            },
            child: Text('跳转原生页面以及传递参数111'),
          ),
        ],
      ),
    );
  }
}