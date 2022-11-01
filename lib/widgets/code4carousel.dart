import 'dart:async';

import 'package:flutter/material.dart';
import 'package:queen/widgets/code4Indicator.dart';

///
///
///自動輪播圖widget
///
class Code4carousel extends StatefulWidget {
  final List<String> imagePaths;
  final double height;
  final int imageListSize;
  const Code4carousel(
      {super.key,
      required this.imagePaths,
      required this.height,
      required this.imageListSize});

  @override
  State<Code4carousel> createState() => _Code4carouselState();
}

class _Code4carouselState extends State<Code4carousel> {
  PageController pageController = PageController();
  late PageView pageView;

  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _getPageView();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          Container(
            child: pageView,
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: _getIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _getIndicator() {
    return Code4Indicator(
      dotCount: widget.imagePaths.length,
      currentIndex: currentIndex,
      dotColor: const Color.fromRGBO(255, 255, 255, 1),
      dotSelectedColor: const Color.fromRGBO(255, 255, 255, 0.3),
      dotPadding: 12,
      dotSize: 14,
      onItemTap: (index) {
        pageController.jumpToPage(index);
      },
    );
  }

  Widget _getPageView() {
    return pageView = PageView.builder(
      itemCount: widget.imagePaths.length,
      itemBuilder: (BuildContext context, int index) {
        return Image(
          image: AssetImage(widget.imagePaths[index]),
          fit: BoxFit.cover,
        );
      },
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      controller: pageController,
    );
  }

  void startTimer() {
    //间隔三秒时间
    _timer = Timer.periodic(const Duration(milliseconds: 3000), (value) {
      currentIndex++;
      if (currentIndex == widget.imageListSize) {
        currentIndex = 0;
      }
      //触发轮播切换
      pageController.animateToPage(currentIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      //刷新
      setState(() {});
    });
  }
}
