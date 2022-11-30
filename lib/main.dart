import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_flutter_plugin/v2_tx_live_premier.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:queen/coomon/config/Config.dart';
import 'package:queen/coomon/utils/NavigatorUtils.dart';
import 'package:queen/debug/generate_test_user_sig.dart';
import 'package:queen/languages/app_localization_delegate.dart';
import 'package:queen/pages/HomeNavigationBarPage.dart';
import 'package:queen/pages/WelcomePage.dart';
import 'package:queen/pages/loginPage/LoginPage.dart';
import 'providers/BottomNavigationBarProvider.dart';
import 'providers/SearchFilterWidgetProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

final _purchaseConfig =
    PurchasesConfiguration('appl_hYARrHmxJwAeGzRsMwEoaJIpOnh');
// PurchasesConfiguration('');
void main() async {
  runApp(
    WelcomePage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(
          const MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initSet();
  }

  setupLicense() {
    // 当前应用的License LicenseUrl
    V2TXLivePremier.setObserver(onPremierObserver);
    V2TXLivePremier.setLicence(
        Config.tencentLiveLicenceUrl, Config.tencentLiveLicenceKey);
  }

  onPremierObserver(V2TXLivePremierObserverType type, param) {
    debugPrint("==premier listener type= ${type.toString()}");
    debugPrint("==premier listener param= $param");
  }

  @override
  Widget build(BuildContext context) {
    ///設定手機畫面固定直立上方
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    ScreenUtil.init(context, minTextAdapt: true);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BottomNavigationBarProvider>(
            create: (BuildContext context) {
              return BottomNavigationBarProvider();
            },
          ),
          ChangeNotifierProvider<SearchFilterWidgetProvider>(
            create: (BuildContext context) {
              return SearchFilterWidgetProvider();
            },
          ),
        ],
        child: OverlaySupport(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'queen',
            theme: ThemeData(
              primaryColor: Colors.white,
            ),
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              LocaleNamesLocalizationsDelegate(),
              APPLocalizationDelegate.delegate
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorKey: NavigatorUtils.navigatorKey,
            initialRoute: '/login',
            routes: {
              '/login': (BuildContext context) => const LoginPage(),
              '/root': (BuildContext context) => const HomeNavigationBarPage(),
            },
            builder: (context, widget) {
              widget = EasyLoading.init()(context, widget);
              widget = MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget);
              return widget;
            },
            home: const LoginPage(),
          ),
        ));
  }

  /// register notification

  initSet() async {
    WidgetsFlutterBinding.ensureInitialized();

    ///騰訊SDK設定使用////
    final appDocumentDirectory =
        await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    setupLicense();
    ///////////////////
    ///app內購設定使用///
    await Purchases.configure(_purchaseConfig);
  }
}
