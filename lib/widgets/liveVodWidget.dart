import 'package:flutter/material.dart';
import 'package:queen/models/liveList.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///
/// 首頁、live
///
class LiveWidget extends StatelessWidget {
  final LiveList model;
  LiveWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(model.thumbURL))),
        child: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset('assets/images/HomePage/livecorner/LIVE套件.png'),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  width: deviceWidth * 0.43,
                  height: deviceHeight * 0.03,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width: deviceWidth * 0.2,
                        child: Text(
                          model.moduleTitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width: deviceWidth * 0.2,
                        child: Text(
                          model.time,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )))
        ]),
      ),
    );
  }
}
