import 'package:flutter/material.dart';
import 'package:queen/coomon/style/MyStyle.dart';

class RoundedButton extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;

  const RoundedButton({
    required this.name,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.15),
        color: Color(MyColors.hexFromStr("#3b2fab")),
      ),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(
          name,
          style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
        ),
      ),
    );
  }
}

class ConfirmCodeBtn extends StatelessWidget {
  final String name;
  final Color? bgColor;
  final Color? fontColor;
  final Function onPressed;

  const ConfirmCodeBtn({
    required this.name,
    required this.onPressed,
    this.bgColor,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
          backgroundColor: () {
            if (bgColor == null) {
              return MaterialStateProperty.all<Color>(Colors.grey);
            } else {
              return MaterialStateProperty.all<Color>(Colors.blue);
            }
          }(),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))),
      child: Text(
        name,
        style: TextStyle(
            // fontSize: MyScreen.smallFontSize(context),
            color: () {
              if (fontColor == null) {
                return Colors.grey[800];
              } else {
                return fontColor;
              }
            }(),
            height: 1.5),
      ),
    );
  }
}

class SearchGovBtn extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;

  const SearchGovBtn({
    required this.name,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.15),
        color: Colors.blue[300],
      ),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(
          name,
          style: TextStyle(
            fontSize: MyScreen.minBigFontSize(context),
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DatePickerBtn extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;

  const DatePickerBtn({
    required this.name,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(
          name,
          style: TextStyle(
            fontSize: MyScreen.smallFontSize(context),
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class AddBidNameBtn extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;

  const AddBidNameBtn({
    required this.name,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.15),
        color: Colors.blue[300],
      ),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(
          name,
          style: TextStyle(
            fontSize: MyScreen.minBigFontSize(context),
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
