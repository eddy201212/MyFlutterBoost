

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ShowCarPage extends StatefulWidget{
  final title;
  ShowCarPage({Key key,this.title}) : super(key: key);

  _ShowCarPagePage createState() => _ShowCarPagePage();
}

class _ShowCarPagePage extends State<ShowCarPage>{
  @override
  // TODO: implement wantKeepAlive
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: Row(
              children: <Widget>[
                Image.asset('assets/Images/ic_blank_modles.png',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 100,),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Text(
                          '车名:${widget.title}'
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Text(
                            '长宽高:20*40*80'
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Text(
                            '载货体积:0.8m³'
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}