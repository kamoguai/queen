import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/coomon/utils/NavigatorUtils.dart';
import 'package:queen/providers/BottomNavigationBarProvider.dart';
import 'package:queen/widgets/BaseWidget.dart';

class CommonUIWidget extends StatefulWidget {
  final BottomNavigationBarProvider bottomNavigationBarProvider;
  final List<Widget>? appActions;
  final Widget body;
  final AppBar? appbar;

  const CommonUIWidget(
      {Key? key,
      required this.bottomNavigationBarProvider,
      required this.body,
      this.appActions,
      this.appbar})
      : super(key: key);

  @override
  State<CommonUIWidget> createState() => _CommonUIWidgetState();
}

class _CommonUIWidgetState extends State<CommonUIWidget> with BaseWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  late BottomNavigationBarProvider _bottomNavigationBarProvider;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _bottomNavigationBarProvider = widget.bottomNavigationBarProvider;

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: widget.appbar,
      body: widget.body,
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColor()),
          border: const Border(
              top: BorderSide(color: Colors.white30, width: 2),
              bottom: BorderSide(color: Colors.white30, width: 2))),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: _barItems(),
        currentIndex: _bottomNavigationBarProvider.currentIndex,
        selectedItemColor: Colors.amber[800],
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomNavigationBarProvider.currentIndex = index;
            switch (_bottomNavigationBarProvider.currentIndex) {

              ///??????
              case 0:
                if (mounted) {
                  _bottomNavigationBarProvider.showAppActions = true;
                  _bottomNavigationBarProvider.pageTitle = "????????????";
                  _bottomNavigationBarProvider.appActionStr = "??????";
                }
                break;

              ///??????
              case 1:
                if (mounted) {
                  _bottomNavigationBarProvider.showAppActions = false;
                  _bottomNavigationBarProvider.pageTitle = "????????????";
                }
                break;

              ///?????????
              case 2:
                if (mounted) {
                  // NavigatorUtils.goPushAttetionPage(context);
                }
                break;

              ///?????????
              case 3:
                if (mounted) {
                  _bottomNavigationBarProvider.showAppActions = false;
                  _bottomNavigationBarProvider.pageTitle = "????????????";
                }
                break;

              ///????????????
              case 4:
                break;
            }
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _barItems() {
    List<BottomNavigationBarItem> list = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
            'assets/images/Tabbar/icon_tabbar_realhome/Group_30.svg'),
        activeIcon: SvgPicture.asset(
            'assets/images/Tabbar/icon_tabbar_realhome_sel/Group_30.svg',
            color: Colors.amber),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/images/Tabbar/icon_tabbar_live/??????icon??????.svg',
        ),
        activeIcon: SvgPicture.asset(
            'assets/images/Tabbar/icon_tabbar_live_sel/??????icon??????.svg',
            color: Colors.amber),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/images/Tabbar/icon_tabbar_video/?????????icon??????.svg',
        ),
        activeIcon: SvgPicture.asset(
          'assets/images/Tabbar/icon_tabbar_video_sel/icon_tabbar_video_sel.svg',
          color: Colors.amber,
        ),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(
          'assets/images/Tabbar/icon_tabbar_game/?????????-3.png',
        )),
        activeIcon: ImageIcon(AssetImage(
          'assets/images/Tabbar/icon_tabbar_game_sel/?????????.png',
        )),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/images/Tabbar/icon_tabbar_profile/????????????.svg',
        ),
        activeIcon: SvgPicture.asset(
            'assets/images/Tabbar/icon_tabbar_profile_sel/icon_tabbar_profile_sel.svg',
            color: Colors.amber),
        label: '',
      ),
    ];

    return list;
  }
}
