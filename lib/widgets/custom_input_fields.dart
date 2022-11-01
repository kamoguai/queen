import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  CustomTextFormField(
      {required this.onSaved,
      required this.regEx,
      required this.hintText,
      required this.obscureText,
      this.icon,
      this.prefixIcon,
      this.suffixIcon,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (_value) => onSaved(_value),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.black),
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: prefixIcon,
          icon: icon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10)),
    );
  }
}

class CustomLoginTextFormField extends StatelessWidget with BaseWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keybordType;
  late double _deviceHeight;
  late double _deviceWidth;

  CustomLoginTextFormField(
      {required this.onSaved,
      required this.regEx,
      required this.hintText,
      required this.obscureText,
      this.icon,
      this.prefixIcon,
      this.suffixIcon,
      this.keybordType,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      onSaved: (_value) => onSaved(_value!),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.black),
      obscureText: obscureText,
      keyboardType: keybordType,
      validator: validator,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: prefixIcon,
          icon: icon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.only(left: 0)),
    );
  }
}

class CustomTextField extends StatelessWidget with BaseWidget {
  final Function(String) onEditingComplete;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  IconData? icon;

  CustomTextField(
      {required this.onEditingComplete,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: () => onEditingComplete(controller.value.text),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(30, 29, 37, 1.0),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white54),
      ),
    );
  }
}

class CustomTextAreaFormField extends StatelessWidget with BaseWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  CustomTextAreaFormField(
      {required this.onSaved,
      required this.regEx,
      required this.hintText,
      required this.obscureText,
      this.icon,
      this.prefixIcon,
      this.suffixIcon,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (_value) => onSaved(_value),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.black),
      obscureText: obscureText,
      validator: validator,
      minLines: 6,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: prefixIcon,
          icon: icon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10)),
    );
  }
}

class CustomerPhoneTextfield extends StatefulWidget {
  final String regEx;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Widget? suffixIcon;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final TextEditingController controller;
  final TextInputType? keybordType;
  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<PhoneNumber>? onChanged;
  final List<String>? countries;
  final String? initialValue;
  final String? initialCountryCode;
  final AutovalidateMode? autovalidateMode;
  final bool disableLengthCheck;
  final String? invalidNumberMessage;
  final PickerDialogStyle? pickerDialogStyle;
  final String searchText;
  final ValueChanged<Country>? onCountryChanged;

  const CustomerPhoneTextfield(
      {Key? key,
      required this.regEx,
      required this.hintText,
      required this.obscureText,
      this.icon,
      this.suffixIcon,
      this.validator,
      required this.controller,
      this.keybordType,
      this.onSaved,
      this.onChanged,
      this.countries,
      this.initialValue,
      this.initialCountryCode,
      this.autovalidateMode,
      this.disableLengthCheck = false,
      this.invalidNumberMessage,
      this.pickerDialogStyle,
      @Deprecated('Use searchFieldInputDecoration of PickerDialogStyle instead')
          this.searchText = '搜尋國家',
      this.onCountryChanged})
      : super(key: key);

  @override
  State<CustomerPhoneTextfield> createState() => _CustomerPhoneTextfieldState();
}

class _CustomerPhoneTextfieldState extends State<CustomerPhoneTextfield> {
  late double _deviceHeight;
  late double _deviceWidth;
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;

  String? validatorMessage;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries == null
        ? countries
        : countries
            .where((country) => widget.countries!.contains(country.code))
            .toList();
    filteredCountries = _countryList;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere(
          (country) => number.startsWith(country.dialCode),
          orElse: () => _countryList.first);
      number = number.substring(_selectedCountry.dialCode.length);
    } else {
      _selectedCountry = _countryList.firstWhere(
          (item) => item.code == (widget.initialCountryCode ?? 'US'),
          orElse: () => _countryList.first);
    }

    if (widget.autovalidateMode == AutovalidateMode.always) {
      final initialPhoneNumber = PhoneNumber(
        countryISOCode: _selectedCountry.code,
        countryCode: '+${_selectedCountry.dialCode}',
        number: widget.initialValue ?? '',
      );

      final value = widget.validator?.call(initialPhoneNumber);

      if (value is String) {
        validatorMessage = value;
      } else {
        (value as Future).then((msg) {
          validatorMessage = msg;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: widget.controller,
      onSaved: (value) {
        widget.onSaved?.call(
          PhoneNumber(
            countryISOCode: _selectedCountry.code,
            countryCode: '+${_selectedCountry.dialCode}',
            number: value!,
          ),
        );
      },
      onChanged: (value) async {
        final phoneNumber = PhoneNumber(
          countryISOCode: _selectedCountry.code,
          countryCode: '+${_selectedCountry.dialCode}',
          number: value,
        );

        if (widget.autovalidateMode != AutovalidateMode.disabled) {
          validatorMessage = await widget.validator?.call(phoneNumber);
        }

        widget.onChanged?.call(phoneNumber);
      },
      validator: (value) {
        if (!widget.disableLengthCheck && value != null) {
          return value.length >= _selectedCountry.minLength &&
                  value.length <= _selectedCountry.maxLength
              ? null
              : widget.invalidNumberMessage;
        }

        return validatorMessage;
      },
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.black),
      obscureText: widget.obscureText,
      keyboardType: widget.keybordType,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: _buildFlagsButton(),
          icon: widget.icon,
          suffixIcon: widget.suffixIcon,
          contentPadding: EdgeInsets.only(left: 0)),
    );
  }

  Widget _buildFlagsButton() {
    return Padding(
        padding: EdgeInsets.only(right: _deviceWidth * 0.05),
        child: Stack(
          children: [
            InkWell(
                onTap: () {
                  _changeCountry();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: _deviceHeight * 0.025),
                  width: _deviceWidth * 0.2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/注册/login_rect.png"),
                    ),
                  ),
                  child: Text(
                    '+${_selectedCountry.dialCode}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MyScreen.normalPageFontSize(context)),
                  ),
                ))
          ],
        ));
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => CountryPickerDialog(
          style: widget.pickerDialogStyle,
          filteredCountries: filteredCountries,
          searchText: widget.searchText,
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            _selectedCountry = country;
            widget.onCountryChanged?.call(country);
            setState(() {});
          },
        ),
      ),
    );
    if (mounted) setState(() {});
  }
}

class CustomerPhone2Textfield extends StatefulWidget {
  final String regEx;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Widget? suffixIcon;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final TextEditingController controller;
  final TextInputType? keybordType;
  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<PhoneNumber>? onChanged;
  final List<String>? countries;
  final String? initialValue;
  final String? initialCountryCode;
  final AutovalidateMode? autovalidateMode;
  final bool disableLengthCheck;
  final String? invalidNumberMessage;
  final PickerDialogStyle? pickerDialogStyle;
  final String searchText;
  final ValueChanged<Country>? onCountryChanged;

  const CustomerPhone2Textfield(
      {Key? key,
      required this.regEx,
      required this.hintText,
      required this.obscureText,
      this.icon,
      this.suffixIcon,
      this.validator,
      required this.controller,
      this.keybordType,
      this.onSaved,
      this.onChanged,
      this.countries,
      this.initialValue,
      this.initialCountryCode,
      this.autovalidateMode,
      this.disableLengthCheck = false,
      this.invalidNumberMessage,
      this.pickerDialogStyle,
      @Deprecated('Use searchFieldInputDecoration of PickerDialogStyle instead')
          this.searchText = '搜尋國家',
      this.onCountryChanged})
      : super(key: key);

  @override
  State<CustomerPhone2Textfield> createState() =>
      _CustomerPhone2TextfieldState();
}

class _CustomerPhone2TextfieldState extends State<CustomerPhone2Textfield> {
  late double _deviceHeight;
  late double _deviceWidth;
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;

  String? validatorMessage;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries == null
        ? countries
        : countries
            .where((country) => widget.countries!.contains(country.code))
            .toList();
    filteredCountries = _countryList;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere(
          (country) => number.startsWith(country.dialCode),
          orElse: () => _countryList.first);
      number = number.substring(_selectedCountry.dialCode.length);
    } else {
      _selectedCountry = _countryList.firstWhere(
          (item) => item.code == (widget.initialCountryCode ?? 'US'),
          orElse: () => _countryList.first);
    }

    if (widget.autovalidateMode == AutovalidateMode.always) {
      final initialPhoneNumber = PhoneNumber(
        countryISOCode: _selectedCountry.code,
        countryCode: '+${_selectedCountry.dialCode}',
        number: widget.initialValue ?? '',
      );

      final value = widget.validator?.call(initialPhoneNumber);

      if (value is String) {
        validatorMessage = value;
      } else {
        (value as Future).then((msg) {
          validatorMessage = msg;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: widget.controller,
      onSaved: (value) {
        widget.onSaved?.call(
          PhoneNumber(
            countryISOCode: _selectedCountry.code,
            countryCode: '+${_selectedCountry.dialCode}',
            number: value!,
          ),
        );
      },
      onChanged: (value) async {
        final phoneNumber = PhoneNumber(
          countryISOCode: _selectedCountry.code,
          countryCode: '+${_selectedCountry.dialCode}',
          number: value,
        );

        if (widget.autovalidateMode != AutovalidateMode.disabled) {
          validatorMessage = await widget.validator?.call(phoneNumber);
        }

        widget.onChanged?.call(phoneNumber);
      },
      validator: (value) {
        if (!widget.disableLengthCheck && value != null) {
          return value.length >= _selectedCountry.minLength &&
                  value.length <= _selectedCountry.maxLength
              ? null
              : widget.invalidNumberMessage;
        }

        return validatorMessage;
      },
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.black),
      obscureText: widget.obscureText,
      keyboardType: widget.keybordType,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: _buildFlagsButton(),
        icon: widget.icon,
        suffixIcon: widget.suffixIcon,
        // contentPadding: EdgeInsets.only(left: 0)
      ),
    );
  }

  Widget _buildFlagsButton() {
    return Padding(
      padding: EdgeInsets.only(right: _deviceWidth * 0.05),
      child: InkWell(
          onTap: () {
            _changeCountry();
          },
          child: Container(
              width: _deviceWidth * 0.2,
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black))),
              child: Center(
                child: Text(
                  '+${_selectedCountry.dialCode}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MyScreen.normalPageFontSize(context)),
                ),
              ))),
    );
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => CountryPickerDialog(
          style: widget.pickerDialogStyle,
          filteredCountries: filteredCountries,
          searchText: widget.searchText,
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            _selectedCountry = country;
            widget.onCountryChanged?.call(country);
            setState(() {});
          },
        ),
      ),
    );
    if (mounted) setState(() {});
  }
}

class CustomBorderTextFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keybordType;

  CustomBorderTextFormField(
      {required this.onSaved,
      required this.regEx,
      required this.hintText,
      required this.obscureText,
      this.icon,
      this.prefixIcon,
      this.suffixIcon,
      required this.controller,
      this.validator,
      this.keybordType});

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      onChanged: (_value) => onSaved(_value),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.black),
      obscureText: obscureText,
      validator: validator,
      keyboardType: keybordType,
      decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Padding(
              padding: EdgeInsets.only(right: _deviceWidth * 0.05),
              child: Container(
                width: _deviceWidth * 0.2,
                decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.black))),
                child: Center(
                  child: prefixIcon,
                ),
              )),
          icon: icon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10)),
    );
  }
}
