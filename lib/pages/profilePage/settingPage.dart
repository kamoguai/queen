import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/coomon/utils/NavigatorUtils.dart';
import 'package:queen/coomon/utils/cacheUtils.dart';
import 'package:queen/providers/BottomNavigationBarProvider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  List<String> _listItem = ['勿擾', '語言', '清除緩存', '版本更新'];
  bool _switchEvent = false;
  double cache = 0.0;
  late BottomNavigationBarProvider _bottomNavProvider;

  @override
  void initState() {
    super.initState();
    _getCacheSize();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _bottomNavProvider = Provider.of<BottomNavigationBarProvider>(context);
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[300],
        title: Text(
          '設置',
          style: TextStyle(
              fontSize: MyScreen.appBarFontSize(context), color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(color: Colors.grey[300], child: _body()),
    );
  }

  Widget _body() {
    Widget w;

    w = Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return titleItems(index)[index];
            }),
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
                height: 3,
              );
            },
            itemCount: titleItems(-1).length),
        SizedBox(
          height: _deviceHeight * 0.05,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 4.0,
                fixedSize: Size(_deviceWidth * 0.5, _deviceHeight * 0.08)),
            onPressed: () {
              _bottomNavProvider.currentIndex = 0;
              NavigatorUtils.goLoginPge();
            },
            child: Text(
              '登出',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MyScreen.defaultTableCellFontSize(context)),
            ))
      ],
    );

    return w;
  }

  List<Widget> titleItems(int index) {
    List<Widget> list = [];

    for (var dic in _listItem) {
      switch (dic) {
        case '勿擾':
          list.add(SwitchListTile(
            title: Text(
              dic,
              style: TextStyle(
                  fontSize: MyScreen.defaultTableCellFontSize(context)),
            ),
            value: _switchEvent,
            onChanged: (val) {
              setState(() {
                _switchEvent = val;
              });
            },
          ));
          break;
        case '語言':
          list.add(ListTile(
            tileColor: Colors.white,
            title: Text(
              dic,
              style: TextStyle(
                  fontSize: MyScreen.defaultTableCellFontSize(context)),
            ),
          ));
          break;
        case '清除緩存':
          list.add(ListTile(
            tileColor: Colors.white,
            title: Text(
              dic,
              style: TextStyle(
                  fontSize: MyScreen.defaultTableCellFontSize(context)),
            ),
            trailing: Text(
              Utils.renderSize(cache),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: MyScreen.defaultTableCellFontSize(context)),
            ),
            onTap: () async {
              try {
                final _tempDir = await getTemporaryDirectory();
                EasyLoading.show(status: 'clearing');
                await Utils.requestPermission(_tempDir);
                EasyLoading.dismiss();
                EasyLoading.showSuccess('clear success');
              } catch (e) {
                EasyLoading.dismiss();
                EasyLoading.showError('clear fail');
              }
            },
          ));
          break;
        case '版本更新':
          list.add(ListTile(
            tileColor: Colors.white,
            title: Text(
              dic,
              style: TextStyle(
                  fontSize: MyScreen.defaultTableCellFontSize(context)),
            ),
          ));
          break;
      }
      if (dic == '勿擾') {
      } else if (dic == '清除緩存') {
      } else {}
    }
    return list;
  }

  _getCacheSize() async {
    final _tempDir = await getTemporaryDirectory();
    double _cache = await Utils.getTotalSizeOfFileInDir(_tempDir);
    setState(() {
      cache = _cache;
    });
  }
}
