import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:queen/widgets/BaseWidget.dart';

/// 歡迎頁面
class WelcomePage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const WelcomePage({Key? key, required this.onInitializationComplete})
      : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with BaseWidget {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then(
      (_) {
        _setup().then(
          (_) => widget.onInitializationComplete(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return MaterialApp(
      title: 'Queen',
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/Login/bg_login.png"),
            ),
          ),
          child: Center(
              child: Image.asset(
            'assets/images/Login/rc_logo.png',
            scale: 1.0,
          )),
        ),
      ),
    );
  }

  Future<void> _setup() async {
    /// 可以做一些事情
    WidgetsFlutterBinding.ensureInitialized();
  }
}
///Users/kamoguai/Desktop/queen/assets/images/Login/login_app_icon.imageset