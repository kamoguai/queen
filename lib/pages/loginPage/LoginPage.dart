import 'package:flutter/material.dart';
import 'package:queen/coomon/config/Config.dart';
import 'package:queen/coomon/dao/UserInfoDao.dart';
import 'package:queen/coomon/local/LocalStorage.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/coomon/utils/CommonUtils.dart';
import 'package:queen/coomon/utils/NavigatorUtils.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:queen/widgets/custom_input_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String sName = "/login";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with BaseWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  late AppLocalizations localizations;

  final _loginFormKey = GlobalKey<FormState>();

  String? _phone;
  String? _password;
  String? _countryCode;
  bool isEnableSubmitBtn = false;
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController pwdCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    localizations = AppLocalizations.of(context)!;
    return _buildUI();
  }

  Widget _buildUI() {
    return !isLoading
        ? Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/Login/bg_login.png"),
              ),
            ),
          )
        : Scaffold(
            body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/Login/bg_login.png"),
              ),
            ),
            child: SafeArea(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                SizedBox(
                  height: _deviceHeight * 0.05,
                ),
                _logo(),
                SizedBox(
                  height: _deviceHeight * 0.05,
                ),
                _loginForm(),
                SizedBox(
                  height: _deviceHeight * 0.03,
                ),
                _registAndForgotpwd(),
                SizedBox(
                  height: _deviceHeight * 0.05,
                ),
                _loginBtn(),
                SizedBox(
                  height: _deviceHeight * 0.05,
                ),
                _lineView(),
              ]),
            ),
          ));
  }

  Widget _logo() {
    return Container(
      // height: _deviceHeight * 0.1,
      child: Image.asset(
        'assets/images/Login/rc_logo.png',
        scale: 1,
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight * 0.2,
      margin:
          EdgeInsets.only(right: _deviceWidth * 0.1, left: _deviceWidth * 0.1),
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomerPhoneTextfield(
                initialCountryCode: _countryCode,
                controller: phoneCtrl,
                hintText: localizations.loginAccountHint,
                obscureText: false,
                keybordType: TextInputType.number,
                regEx: '',
                suffixIcon: () {
                  if (phoneCtrl.text.isNotEmpty) {
                    return IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        phoneCtrl.clear();
                      },
                    );
                  } else {}
                }(),
                validator: (val) {
                  if (_phone == null || _phone!.isEmpty) {
                    return localizations.loginAccountHint;
                  } else {
                    return null;
                  }
                },
                onChanged: (phone) {
                  setState(() {
                    _phone = phone.number;
                    _countryCode = phone.countryCode;
                  });
                },
              ),
              CustomLoginTextFormField(
                controller: pwdCtrl,
                onSaved: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                hintText: localizations.loginPasswordHint,
                obscureText: true,
                regEx: '',
                suffixIcon: () {
                  if (pwdCtrl.text.isNotEmpty) {
                    return IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        pwdCtrl.clear();
                      },
                    );
                  } else {}
                }(),
                validator: (val) {
                  if (pwdCtrl.text.isEmpty) {
                    return localizations.enterPassword;
                  } else {
                    return null;
                  }
                },
                prefixIcon: Padding(
                    padding: EdgeInsets.only(right: _deviceWidth * 0.05),
                    child: Stack(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: _deviceHeight * 0.025),
                              width: _deviceWidth * 0.2,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/注册/login_rect.png"),
                                ),
                              ),
                              child: Text(
                                '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MyScreen.normalPageFontSize(context)),
                              ),
                            ))
                      ],
                    )),
              ),
            ],
          )),
    );
  }

  Widget _registAndForgotpwd() {
    return Container(
        margin: EdgeInsets.only(
            right: _deviceWidth * 0.1, left: _deviceWidth * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                NavigatorUtils.goRegistPage(context);
              },
              child: Text(
                localizations.loginRegist,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MyScreen.normalPageFontSize(context)),
              ),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                NavigatorUtils.goForgotPwdPage(context);
              },
              child: Text(
                localizations.loginForgot,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MyScreen.normalPageFontSize(context)),
              ),
            ),
          ],
        ));
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        _submitEvent();
      },
      child: Text(
        localizations.loginBtn,
        style: TextStyle(
          fontSize: MyScreen.defaultTableCellFontSize(context),
        ),
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.grey[800],
          onPrimary: Colors.white,
          onSurface: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 4.0,
          fixedSize: Size(_deviceWidth * 0.5, _deviceHeight * 0.08)),
    );
  }

  Widget _lineView() {
    return Container(
      margin:
          EdgeInsets.only(right: _deviceWidth * 0.1, left: _deviceWidth * 0.1),
      height: 1,
      width: double.infinity,
      color: Colors.white,
    );
  }

  initData() async {
    String mobile = await LocalStorage.get(Config.userMobile) ?? "";
    phoneCtrl.text = mobile;
    pwdCtrl.text = await LocalStorage.get(Config.userPwd) ?? "";
    String cc = await LocalStorage.get(Config.countryCode) ?? "";
    _countryCode = await LocalStorage.get(Config.countryCode);
    setState(() {
      _phone = mobile;
      _countryCode = cc.isEmpty ? "" : cc.replaceAll("+", "");
      isLoading = true;
    });
  }

  _submitEvent() {
    print('phone -> $_phone');
    print('pwd -> ${pwdCtrl.text}');
    print('countrycode -> $_countryCode');

    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      _callApiMobileLogin();
    }
  }

  _checkTextField() {
    setState(() {
      if (_phone!.isEmpty || pwdCtrl.text.isEmpty) {
        isEnableSubmitBtn = false;
      } else {
        isEnableSubmitBtn = true;
      }
    });
  }

  _callApiMobileLogin() async {
    Map<String, dynamic> params = {};
    await LocalStorage.save(Config.countryCode, _countryCode!);
    await LocalStorage.save(Config.userMobile, _phone!);
    String mobile = _countryCode!.replaceAll("+", "") + _phone!;
    params["user_login"] = mobile;
    params["user_pass"] = pwdCtrl.text;
    debugPrint(params.toString());
    var res = await UserInfoDao.mobileLogin(params: params);
    if (res != null) {
      if (res.data["code"] != null && res.data["code"] != 0) {
        CommonUtils.showToast(context, msg: res.data["msg"]);
        return;
      } else {
        NavigatorUtils.goHomeNavigationBarPage(context);
      }
    }
  }
}
