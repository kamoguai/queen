import 'package:flutter/material.dart';

///
///
///輪播圖下方圓形按鈕widget
///
class Code4Indicator extends StatelessWidget {
  final int currentIndex;
  final int dotCount;
  final ValueChanged onItemTap;

  final Color dotColor;
  final Color dotSelectedColor;
  final double dotSize;
  final double dotPadding;
  const Code4Indicator({
    super.key,
    required this.currentIndex,
    required this.dotCount,
    required this.onItemTap,
    required this.dotColor,
    required this.dotSelectedColor,
    required this.dotSize,
    required this.dotPadding,
  });

  Widget _renderItem(int index) {
    var color = currentIndex == index ? dotColor : dotSelectedColor;
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(dotPadding),
        child: Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
      onTap: () {
        onItemTap(index);
      },
    );
  }

  double getWidth() {
    return dotSize * dotCount + dotPadding * (dotCount + 5);
  }

  double getHeight() {
    return dotSize + dotPadding * 2;
  }

  Widget _getItems() {
    return SizedBox(
      width: getWidth(),
      height: getHeight(),
      child: ListView.builder(
        itemCount: dotCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _renderItem(index);
        },
      ),
    );
  }

  @override
  build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // transparent black background
        Container(
          height: getHeight(),
          // color: Color.fromRGBO(0, 0, 0, 0.6),
          color: Colors.transparent,
        ),

        // dot list
        Container(
          alignment: Alignment.center,
          child: _getItems(),
        ),
      ],
    );
  }
}
