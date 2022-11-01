import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:queen/pages/homePage/HomePage.dart';
import 'package:queen/providers/BottomNavigationBarProvider.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:queen/widgets/CommonUIWidget.dart';

///
///
///主要bottomBar導航頁面
///
class HomeNavigationBarPage extends StatefulWidget {
  static const String sName = "/root";
  const HomeNavigationBarPage({super.key});

  @override
  State<HomeNavigationBarPage> createState() => _HomeNavigationBarPageState();
}

class _HomeNavigationBarPageState extends State<HomeNavigationBarPage>
    with BaseWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  late BottomNavigationBarProvider _bottomNavProvider;
  final Widget svg = SvgPicture.asset(
    'assets/images/Tabbar/icon_tabbar_video/短視頻icon套件.svg',
  );
  final List<Widget> _page = [
    const HomePage(),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.pink,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.brown,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _bottomNavProvider = Provider.of<BottomNavigationBarProvider>(context);
    return _buildUI();
  }

  Widget _buildUI() {
    return WillPopScope(
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: CommonUIWidget(
              bottomNavigationBarProvider: _bottomNavProvider,
              body: _page[_bottomNavProvider.currentIndex],
            ),
          ),
        ),
        onWillPop: () {
          return exitDialog(context);
        });
  }
}
