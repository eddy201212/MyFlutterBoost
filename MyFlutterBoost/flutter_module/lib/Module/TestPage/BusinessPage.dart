import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/Module/TestPage/showCar/ShowCarPage.dart';
import 'package:flutter_module/main.dart';

class BusinessPage extends StatefulWidget {
  final Map params;
  BusinessPage({Key key,@required this.params}) : super(key: key);

  _BusinessPageState createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  String _title;
  int _curSelectedIndex = 0;
  TabController _tabController;
  List _titleNameList;
  List<Widget> _tabList = List();

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

    _titleNameList = ['小面包车(pk)','小面包车','大车接送测试','更多的车','这里还有一个','又有一个'];

    for(int i = 0; i <_titleNameList.length;i++){
  _tabList.add(ShowCarPage(title: _titleNameList[i],));
}
    _tabController = TabController(length: _tabList.length, vsync: this);
    _tabController.addListener((){
      _curSelectedIndex = _tabController.index;
      setState(() {

      });
    });
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
  void _openNativePage(String url) async {
    // 如果参数obj是model，需要调用model对应的类名.toJson()方法转为json对象
    Map<String, dynamic> jsonObj = Map();
    // jsonObj = (obj as News.Result).toJson()
    // 因为我要跳转native的页面故加一个type字段
    // 每个Flutter的页面都是从native调用进行实例化FlutterViewContainer的
    // native通过解析此处的type字段决定跳转Native还是Flutter页面
    jsonObj["type"] = "App";
    FlutterBoost.singleton.open(url, urlParams:jsonObj);
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        body: Container(
          color: Colors.grey,
          child: Column(
            children: <Widget>[

              Container(
                color: Colors.white,
                height: 44,
                width: double.infinity,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    String iconName = _titleNameList[index] ;
                    BorderSide borderSide = BorderSide(
                        width: 1,
                        color: Color.fromRGBO(227, 227, 227, 1)
                    );
                    BoxDecoration boxDecoration;
                    if(_curSelectedIndex == index){
                      BorderSide bottomBorderSide = BorderSide(
                        width: 2,
                        color: Colors.orange,
                      );
                      boxDecoration = new BoxDecoration(
                        border: new Border(
                          bottom: bottomBorderSide,
                        ),
                      );
                    }else{
                    }
                    return GestureDetector(
                      onTap: (){
                        tapIndex(index);
                      },
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        decoration: boxDecoration,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          iconName,
                          style: TextStyle(
                              color: (_curSelectedIndex == index)?Colors.orange:Colors.black
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _titleNameList.length,
                  scrollDirection:Axis.horizontal,
                ),
              ),
              Container(
                height: 201,
                width: double.infinity,
                color: Colors.red,
                child: Container(
                    child: TabBarView(
                      children: _tabList,
                      controller: _tabController,
                    )),
              ),
                Container(
                  color: Colors.white,
//                  height: 100,
                  margin: EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color:Colors.white,
                      boxShadow: [BoxShadow(color: Color(0x1A000000), offset: Offset(0, 0),blurRadius:10)],
                      borderRadius:
                      BorderRadius.all(Radius.circular(4.0),
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Image.asset(
                                      'assets/Images/icon_qd.png',
                                      width: 14,
                                      height: 14,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        '飞机场',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                          onTap: (){

                          },
                        ),
                        GestureDetector(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(6, 4, 0, 0),
                                    padding: EdgeInsets.fromLTRB(21, 4, 0, 20),
                                    decoration: new BoxDecoration(
                                      border: new Border(left: BorderSide(
                                          width: 1,
                                          color: Color.fromRGBO(227, 227, 227, 1)
                                      )),
                                    ),
                                    child: Text(
                                      '起点的地址',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                      ),
                                      maxLines: 10,
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                          onTap: (){

                          },
                        ),
                        GestureDetector(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Image.asset(
                                      'assets/Images/icon_zd.png',
                                      width: 14,
                                      height: 14,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        '卓悦汇',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                          ),
                          onTap: (){

                          },
                        ),
                        GestureDetector(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(6, 4, 0, 0),
                                    padding: EdgeInsets.fromLTRB(21, 4, 0, 0),
                                    child: Text(
                                      '上梅林100号',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                      ),
                                      maxLines: 10,
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                          onTap: (){

                          },
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          height: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '添加地址',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 46,
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: new BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(23.0)
                    ),
                  ),
                  child:Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.deepOrange,
                          child: MaterialButton(
                            minWidth: double.infinity,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '现在叫车',
                                )
                              ],
                            ),
                            onPressed:(){
                              _openNativePage('callCarNow');
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child:Container(
                          color: Colors.orange,
                          child: MaterialButton(
                            minWidth: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '预约叫车',
                                )
                              ],
                            ),
                            onPressed:(){
                              _openNativePage('callCarForTime');
                            },
                          ),
                        ) ,
                      )
                    ],
                  ) ,
                ),
              )

            ],
          ),
        ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  tapIndex(int index){
_curSelectedIndex = index;
_tabController.animateTo(index);
setState(() {

});
  }
}