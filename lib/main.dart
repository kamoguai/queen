import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_flutter_plugin/v2_tx_live_premier.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:queen/coomon/utils/NavigatorUtils.dart';
import 'package:queen/debug/generate_test_user_sig.dart';
import 'package:queen/pages/HomeNavigationBarPage.dart';
import 'package:queen/pages/WelcomePage.dart';
import 'package:queen/pages/loginPage/LoginPage.dart';
import 'providers/BottomNavigationBarProvider.dart';
import 'providers/SearchFilterWidgetProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

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
    var LICENSEURL = GenerateTestUserSig.LICENSEURL;
    // 当前应用的License Key
    var LICENSEURLKEY = GenerateTestUserSig.LICENSEURLKEY;
    V2TXLivePremier.setObserver(onPremierObserver);
    V2TXLivePremier.setLicence(LICENSEURL, LICENSEURLKEY);
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
              LocaleNamesLocalizationsDelegate()
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            // localizationsDelegates: GlobalMaterialLocalizations.delegates,
            // supportedLocales: const [Locale('zh', 'CH'), Locale('en', 'US')],
            // locale: const Locale('zh'),
            navigatorKey: NavigatorUtils.navigatorKey,
            initialRoute: '/login',
            routes: {
              '/login': (BuildContext context) => const LoginPage(),
              '/root': (BuildContext context) => const HomeNavigationBarPage(),
            },
            builder: (context, widget) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!);
            },
            home: const LoginPage(),
          ),
        ));
  }

  /// register notification

  initSet() async {
    WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory =
        await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    setupLicense();
  }
}
