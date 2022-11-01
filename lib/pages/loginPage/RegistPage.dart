import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:queen/coomon/dao/UserInfoDao.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/coomon/utils/CommonUtils.dart';
import 'package:queen/coomon/utils/NavigatorUtils.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:queen/widgets/custom_input_fields.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> with BaseWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  late AppLocalizations localizations;
  final TextEditingController accountCtrl = TextEditingController();
  final TextEditingController newPwdCtrl = TextEditingController();
  final TextEditingController verifyCodeCtrl = TextEditingController();
  final TextEditingController confirmPwdCtrl = TextEditingController();
  final _submitFormKey = GlobalKey<FormState>();
  String? _phone;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    localizations = AppLocalizations.of(context)!;
    return _buildUI();
  }

  Widget _buildUI() {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          localizations.registTitle,
          style: TextStyle(
              color: Colors.grey, fontSize: MyScreen.appBarFontSize(context)),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: _body(),
    ));
  }

  ///body
  Widget _body() {
    Widget w;
    w = Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.05,
                vertical: _deviceHeight * 0.05),
            child: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  _submitForm(),
                  SizedBox(
                    height: _deviceHeight * 0.05,
                  ),
                  _submitButton(),
                ],
              )),
            )));
    ;
    return w;
  }

  ///bottomBar
  Widget _bottomBar() {
    Widget w;
    w = SizedBox(
      height: deviceHeight10(context),
    );
    return w;
  }

  Widget _submitForm() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Form(
          key: _submitFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CustomBorderTextFormField(
              //   controller: newPwdCtrl,
              //   onSaved: (_value) {},
              //   hintText: localizations.enterPassword,
              //   obscureText: true,
              //   regEx: '',
              //   prefixIcon: Text(
              //     localizations.countryArea,
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: MyScreen.defaultTableCellFontSize(context)),
              //   ),
              //   suffixIcon: () {
              //     if (newPwdCtrl.text.isNotEmpty) {
              //       return IconButton(
              //         icon: Icon(Icons.clear),
              //         onPressed: () {
              //           newPwdCtrl.clear();
              //         },
              //       );
              //     } else {
              //       // return Container()
              //     }
              //   }(),
              //   validator: (_value) {
              //     if (newPwdCtrl.text.isEmpty) {
              //       return localizations.enterPassword;
              //     }
              //   },
              // ),
              CustomerPhone2Textfield(
                controller: accountCtrl,
                hintText: localizations.loginAccountHint,
                obscureText: false,
                keybordType: TextInputType.number,
                regEx: '',
                initialCountryCode: 'VN',
                suffixIcon: () {
                  if (accountCtrl.text.isNotEmpty) {
                    return IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        accountCtrl.clear();
                      },
                    );
                  } else {
                    // return Container()
                  }
                }(),
                onChanged: (phone) {
                  setState(() {
                    _phone = phone.completeNumber;
                    // _checkTextField();
                  });
                },
              ),
              Stack(
                children: [
                  CustomBorderTextFormField(
                    controller: verifyCodeCtrl,
                    onSaved: (_value) {},
                    hintText: localizations.enterVerifyCode,
                    obscureText: false,
                    keybordType: TextInputType.number,
                    regEx: '',
                    prefixIcon: Image.asset(
                      'assets/images/注册/regist_code.png',
                      scale: 2,
                    ),
                    suffixIcon: () {
                      if (verifyCodeCtrl.text.isNotEmpty) {
                        return IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            verifyCodeCtrl.clear();
                          },
                        );
                      } else {
                        // return Container()
                      }
                    }(),
                    validator: (_value) {
                      if (verifyCodeCtrl.text.isEmpty) {
                        return "";
                      }
                    },
                  ),
                  Positioned(
                      right: 0,
                      child: TextButton(
                        child: Text(
                          localizations.getVerifyCode,
                          style: TextStyle(color: Colors.purple),
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_phone != null && _phone!.isNotEmpty) {
                            _callApiGetCapcha();
                          } else {
                            CommonUtils.showToast(context,
                                msg: localizations.loginAccountHint);
                            return;
                          }
                        },
                      ))
                ],
              ),
              CustomBorderTextFormField(
                controller: newPwdCtrl,
                onSaved: (_value) {},
                hintText: localizations.enterPassword,
                obscureText: true,
                regEx: '',
                prefixIcon: Image.asset(
                  'assets/images/注册/regist_pwd.png',
                  scale: 2,
                ),
                suffixIcon: () {
                  if (newPwdCtrl.text.isNotEmpty) {
                    return IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        newPwdCtrl.clear();
                      },
                    );
                  } else {
                    // return Container()
                  }
                }(),
                validator: (_value) {
                  if (newPwdCtrl.text.isEmpty) {
                    return localizations.enterPassword;
                  }
                },
              ),
              CustomBorderTextFormField(
                controller: confirmPwdCtrl,
                onSaved: (_value) {},
                hintText: localizations.confirmPassword,
                obscureText: true,
                regEx: '',
                prefixIcon: Image.asset(
                  'assets/images/注册/regist_pwd.png',
                  scale: 2,
                ),
                suffixIcon: () {
                  if (confirmPwdCtrl.text.isNotEmpty) {
                    return IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        newPwdCtrl.clear();
                      },
                    );
                  } else {
                    // return Container()
                  }
                }(),
                validator: (_value) {
                  if (confirmPwdCtrl.text.isEmpty) {
                    return localizations.confirmPassword;
                  } else if (newPwdCtrl.text != confirmPwdCtrl.text) {
                    return localizations.confirmPassword;
                  }
                },
              ),
            ],
          )),
    );
  }

  Widget _submitButton() {
    return Container(
        width: _deviceWidth * 0.3,
        child: ElevatedButton(
            onPressed: () async {
              if (_submitFormKey.currentState!.validate()) {
                _callApiRegist();
              }
            },
            child: Text(
              localizations.registSubmitBtn,
              style: TextStyle(
                  fontSize: MyScreen.smallFontSize(context),
                  color: () {
                    if (accountCtrl.text.isNotEmpty &&
                        newPwdCtrl.text.isNotEmpty) {
                      return Colors.grey[600];
                    } else {
                      return Colors.white;
                    }
                  }()),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.grey[800],
                onPrimary: Colors.white,
                onSurface: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 4.0,
                fixedSize: Size(_deviceWidth * 0.5, _deviceHeight * 0.08))));
  }

  _callApiGetCapcha() async {
    Map<String, dynamic> params = {};
    String mobile = _phone!.replaceAll("+", "");
    params["mobile"] = mobile;
    String encode = "$mobile&76576076c1f5f657b634e966c8836a06";
    params["sign"] = md5.convert(utf8.encode(encode)).toString();

    var res = await UserInfoDao.getCapcha(params: params);
    if (res != null) {
      if (res.data["code"] == 1002) {
        CommonUtils.showToastDelay(context, msg: res.data["msg"]);
      } else {
        CommonUtils.showToastDelay(context, msg: res.data["msg"]);
      }
    }
  }

  _callApiRegist() async {
    Map<String, dynamic> params = {};
    String mobile = _phone!.replaceAll("+", "");
    params["user_login"] = mobile;
    params["user_pass"] = newPwdCtrl.text;
    params["user_pass2"] = confirmPwdCtrl.text;
    params["code"] = verifyCodeCtrl.text;

    var res = await UserInfoDao.registMobile(params: params);
    if (res != null) {
      if (res.data["code"] == 1005) {
        CommonUtils.showToastDelay(context, msg: res.data["msg"]);
      } else if (res.data["code"] == 0) {
        CommonUtils.showToastDelay(context, msg: res.data["msg"]);
        params.clear();
        String source = "";
        if (Platform.isAndroid) {
          source = "android";
        } else {
          source = "ios";
        }

        params["user_login"] = mobile;
        params["user_pass"] = newPwdCtrl.text;
        params["source"] = source;
        params["pushid"] = "";
        var resLogin = await UserInfoDao.mobileLogin(params: params);
        if (resLogin != null) {
          NavigatorUtils.goHomeNavigationBarPage(context);
        }
      }
    }
  }
}
